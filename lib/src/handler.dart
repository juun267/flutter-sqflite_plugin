import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_plugin/src/constant/enum.dart';
import 'package:sqflite_plugin/src/model/sqflite_base_model.dart';
import 'package:sqflite_plugin/src/util/dql_util.dart';
import 'package:sqflite_plugin/sqflite_plugin.dart';

abstract class SQFLiteHandler {
  int databaseVersion = 1;

  // SQL statement to create the table
  String get createTableSql;

  // Make this a singleton class.
  // Only allow a single open connection to the database.
  static Database? _database;
  Future<Database> get database async {
    // Check if the _database is already initialized
    if (_database != null) {
      // Compare the path of the current database with the new one
      String currentPath = _database!.path;
      String newPath = join(await getDatabasesPath(), '$tableName.db');

      if (currentPath != newPath) {
        // If paths differ, reinitialize the database
        _database = await _initDatabase();
      }
    } else {
      _database = await _initDatabase();
    }

    return _database!;
  }

  // Abstract property for table name
  String get tableName;

  // Open the database and create it if it doesn't exist.
  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), '$tableName.db');
    final Database database = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (db, version) => onCreate(db: db, version: version),
      onUpgrade: (db, oldVersion, newVersion) => onUpgrade(db: db, oldVersion: oldVersion, newVersion: newVersion),
    );
    await _setDatabase();
    return database;
  }

  Future onUpgrade ({required Database db, required int oldVersion, required int newVersion}) async {
    final List<Map<String, String>> lackKeysMap = await Util.getLackMapList(tableName: tableName, createTableSql: createTableSql);
    if (oldVersion < newVersion) {
      lackKeysMap.forEach((mapInfo) {
        final String key = mapInfo.keys.single;
        final String type = mapInfo.values.single;
        final String sqlStr = 'ALTER TABLE $tableName ADD COLUMN $key $type';
        db.execute(sqlStr);
      });
    }
  }

  Future onCreate({required Database db, required int version}) async {
    await db.execute(createTableSql);
  }

  /// 記錄以提供DB進行自動化Migration用
  Future<void> _setDatabase() async {
    final SqfliteLogModel logModel = SqfliteLogModel();

    /// SqfliteLogModel 本身不存入
    if(tableName == logModel.tableName) {
      return ;
    }

    final SqfliteLogModel model = SqfliteLogModel(
      tableModelName: tableName,
      version: databaseVersion,
      tableScripts: createTableSql
    );
    final bool isContain = await Util.checkLogContain(model);
    if(isContain) {
      return ;
    }

    await logModel.insertOrReplaceBatch(models: [model]);
  }

  // Database helper methods:

  /// roll back effect.
  Future<List<int>> insert<T extends SQFLiteBaseTable>({ required List<T> models, required SetDatabaseType setType }) async {
    List<int> results = [];
    switch (setType) {
      case SetDatabaseType.insertBatch:
        results = await insertOrReplaceBatch(models: models);
      case SetDatabaseType.insert:
        results = await insertOrReplace(models: models);
      default:
        break;
    }

    return results;
  }



  Future<List<int>> insertOrReplace<T extends SQFLiteBaseTable>({required List<T> models}) async {
    final Database db = await database;
    List<int> results = [];
    try {
      for (T model in models) {
        final Map<String, dynamic> insertModel = model.toMap();
        int id = await db.insert(
            tableName,
            insertModel,
            conflictAlgorithm: ConflictAlgorithm.replace
        );
        results.add(id);
      }
      return results;
    } catch (e) {
      print('Batch insert or replace error: $e');
      return [];
    }
  }

  /// roll back effect && batch 批量處理
  Future<List<int>> insertOrReplaceBatch<T extends SQFLiteBaseTable>({required List<T> models}) async {
    final Database db = await database;
    List<int> ids = [];

    // 判斷陣列大小
    if (models.length == 1) {
      // 如果列表中只有一个模型，就使用事务进行单个插入或替换
      int? id;
      try {
        final Map<String, dynamic> insertModel = models.first.toMap();
        id = await db.insert(tableName, insertModel, conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        print('Insert or replace error: $e');
        id = 0; // 发生错误时返回0表示失败
      }
      ids.add(id);
    } else {
      // 使用batch批量處理
      final Batch batch = db.batch();
      for (var model in models) {
        final Map<String, dynamic> insertModel = model.toMap();
        batch.insert(tableName, insertModel, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      // 結果
      final results = await batch.commit();
      for (var result in results) {
        // 每个插入操作的结果是插入行的ID，如果发生错误可能返回null
        ids.add(result != null ? int.tryParse(result.toString()) ?? 0 : 0);
      }
    }

    return ids; // 返回所有插入或替換操作的ID列表
  }

  Future<List<Map<String, dynamic>>> selectMatching<T extends SQFLiteBaseTable>({
    T? model
  }) async {
    Database db = await database;

    /// model 為 NULL 之後，直接return 為 select 全 table
    if (model == null) {
      return await db.query(tableName);
    }

    Map<String, dynamic> map = model.toMap();

    // Filter out null values and create WHERE clause
    List<String> whereNameList = [];
    List<dynamic> whereValueList = [];
    map.forEach((key, value) {
      if (value != null) {
        whereNameList.add(key);
        whereValueList.add(value);
      }
    });
    String? whereNameCondition = (whereNameList == []) ? null : whereNameList.map((item) => '$item = ?').join(' AND ');
    List<dynamic>? whereValueCondition = (whereValueList == []) ? null : whereValueList;

    return await db.query(tableName, where: whereNameCondition, whereArgs: whereValueCondition);
  }

  /// roll back effect.
  Future<int> update<T extends SQFLiteBaseTable>({
    required T updateModel,
    required T whereModel,
  }) async {
    try {
      Database db = await database;

      Map<String, dynamic> updateMap = updateModel.toMap();

      // Filter out null values in the update map
      Map<String, dynamic> nonNullUpdateMap = {};
      updateMap.forEach((key, value) {
        if (value != null) {
          nonNullUpdateMap[key] = value;
        }
      });

      Map<String, dynamic> whereMap = whereModel.toMap();

      // Filter out null values and create WHERE clause
      List<String> whereNameList = [];
      List<dynamic> whereValueList = [];
      whereMap.forEach((key, value) {
        if (value != null) {
          whereNameList.add(key);
          whereValueList.add(value);
        }
      });

      String? whereNameCondition = (whereNameList == []) ? null : whereNameList.map((item) => '$item = ?').join(' AND ');
      List<dynamic>? whereValueCondition = (whereValueList == []) ? null : whereValueList;

      return await db.update(tableName, nonNullUpdateMap, where: whereNameCondition, whereArgs: whereValueCondition);
    } catch (e) {
      print('update error: $e');
      return 0;
    }
  }

  /// roll back effect.
  Future<int> delete<T extends SQFLiteBaseTable>({
    T? whereModel,
  }) async {
    try {
      Database db = await database;

      if (whereModel == null) {
        // If whereModel is not provided, delete all rows
        return await db.delete(tableName);
      }

      Map<String, dynamic> whereMap = whereModel.toMap();

      // Filter out null values and create WHERE clause
      List<String> whereNameList = [];
      List<dynamic> whereValueList = [];
      whereMap.forEach((key, value) {
        if (value != null) {
          whereNameList.add(key);
          whereValueList.add(value);
        }
      });

      String? whereNameCondition = (whereNameList == []) ? null : whereNameList.map((item) => '$item = ?').join(' AND ');
      List<dynamic>? whereValueCondition = (whereValueList == []) ? null : whereValueList;

      return await db.delete(tableName, where: whereNameCondition, whereArgs: whereValueCondition);
    } catch (e) {
      print('delete error: $e');
      return 0;
    }
  }

  /// 情境：
  /// 我在使用Friends的時候，透過FOREIGN KEY拿到Users的avatar與status資料
  ///
  /// joinWithTable(
  ///   targetTable: ChatUserModel,
  ///   foreignKey: 'userId',
  ///   targetTableColumns: ['userId', 'avatar', 'status'],
  ///   onCondition: 'friendId'
  /// );
  ///
  ///   語法：
  ///     String query = '''
  ///       SELECT Users.userID, Users.avatar, Users.status
  ///       FROM Users
  ///       INNER JOIN Friends ON Users.userID = Friends.friendID;
  ///     ''';
  Future<List<Map<String, Object?>>> joinWithTable<T extends SQFLiteBaseTable>({
    required SQFLiteHandler targetTable,
    required String foreignKey,
    required List<String> targetTableColumns,
    required String onCondition
  }) async {
    try {
      Database db = await database;

      /// SQL 語法
      final query = SQFLiteDQLUtil.joinQuery(
          targetTable: targetTable.tableName,
          foreignKey: foreignKey,
          mainTableColumns: targetTableColumns,
          joinTable: tableName,
          onCondition: onCondition
      );

      return await db.rawQuery(query);
    } catch (e) {
      print('join error: $e');
      return [];
    }
  }
}
