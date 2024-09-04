import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite_plugin/sqflite_plugin.dart';

part 'chat_user_model.g.dart';

@JsonSerializable()
class ChatUserModel extends SQFLiteHandler implements SQFLiteBaseTable {
  final ProviderRef? ref;

  @JsonKey(name: 'userId')
  final num? userId;
  @JsonKey(name: 'roomIcon')
  final String? roomIcon;
  @JsonKey(name: 'cohesionLevel')
  final num? cohesionLevel;
  @JsonKey(name: 'userCount')
  final num? userCount;
  @JsonKey(name: 'isOnline')
  final num? isOnline;
  @JsonKey(name: 'userName')
  final String? userName;
  @JsonKey(name: 'roomId')
  final num? roomId;
  @JsonKey(name: 'roomName')
  final String? roomName;
  @JsonKey(name: 'points')
  final num? points;
  @JsonKey(name: 'remark')
  final String? remark;
  @JsonKey(name: 'unRead')
  final num? unRead;
  @JsonKey(name: 'recentlyMessage')
  final String? recentlyMessage;
  @JsonKey(name: 'pinTop')
  final num? pinTop;
  @JsonKey(name: 'timeStamp')
  final num? timeStamp;
  @JsonKey(name: 'charmCharge')
  final String? charmCharge;
  @JsonKey(name: 'notificationFlag')
  final num? notificationFlag;
  /// 訊息的狀態：0(傳送中)，1(傳送成功)，2(傳送失敗)
  @JsonKey(name: 'sendStatus')
  final num? sendStatus;

  ChatUserModel({
    this.ref,
    this.userId,
    this.roomIcon,
    this.cohesionLevel,
    this.userCount,
    this.isOnline,
    this.userName,
    this.roomId,
    this.roomName,
    this.points,
    this.remark,
    this.unRead,
    this.recentlyMessage,
    this.pinTop,
    this.timeStamp,
    this.charmCharge,
    this.notificationFlag,
    this.sendStatus,
  });

  @override
  int get databaseVersion => 2;

  @override
  String get createTableSql => SQFLiteDDLUtil.create(model: ChatUserModel(ref: ref));

  @override
  String get tableName => 'ChatUserModel';

  @override
  List<SQFLiteColumnModel> get columns => [
    SQFLiteColumnModel(name: 'userId', type: num, isPrimaryKey: true),
    SQFLiteColumnModel(name: 'roomIcon', type: String),
    SQFLiteColumnModel(name: 'cohesionLevel', type: num),
    SQFLiteColumnModel(name: 'userCount', type: num),
    SQFLiteColumnModel(name: 'isOnline', type: num),
    SQFLiteColumnModel(name: 'userName', type: String, isPrimaryKey: true),
    SQFLiteColumnModel(name: 'roomId', type: num),
    SQFLiteColumnModel(name: 'roomName', type: String),
    SQFLiteColumnModel(name: 'points', type: num),
    SQFLiteColumnModel(name: 'remark', type: String),
    SQFLiteColumnModel(name: 'unRead', type: num),
    SQFLiteColumnModel(name: 'recentlyMessage', type: String),
    SQFLiteColumnModel(name: 'pinTop', type: num),
    SQFLiteColumnModel(name: 'timeStamp', type: num),
    SQFLiteColumnModel(name: 'charmCharge', type: String),
    SQFLiteColumnModel(name: 'notificationFlag', type: num),
    SQFLiteColumnModel(name: 'sendStatus', type: num),

  ];

  @override
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'roomIcon': roomIcon,
      'cohesionLevel': cohesionLevel,
      'userCount': userCount,
      'isOnline': isOnline,
      'userName': userName,
      'roomId': roomId,
      'roomName': roomName,
      'points': points,
      'remark': remark,
      'unRead': unRead,
      'recentlyMessage': recentlyMessage,
      'pinTop': pinTop,
      'timeStamp': timeStamp,
      'charmCharge': charmCharge,
      'notificationFlag': notificationFlag,
      'sendStatus':sendStatus,
    };
  }

  // factory ChatUserModel.fromJson(Map<String, dynamic> jsonData) {
  //   return ChatUserModel(
  //     userId: jsonData['userId'] as num?,
  //     roomIcon: jsonData['roomIcon'] as String?,
  //     cohesionLevel: jsonData['cohesionLevel'] as num?,
  //     userCount: jsonData['userCount'] as num?,
  //     isOnline: jsonData['isOnline'] as num?,
  //     userName: jsonData['userName'] as String?,
  //     roomId: jsonData['roomId'] as num?,
  //     roomName: jsonData['roomName'] as String?,
  //     points: jsonData['points'] as num?,
  //     remark: jsonData['remark'] as String?,
  //     unRead: jsonData['unRead'] as num?,
  //     recentlyMessage: jsonData['recentlyMessage'] as String?,
  //     pinTop: jsonData['pinTop'] as num?,
  //     timeStamp: jsonData['timeStamp'] as num?,
  //     charmCharge: jsonData['charmCharge'] as String?,
  //     notificationFlag: jsonData['notificationFlag'] as num?,
  //     sendStatus: jsonData['sendStatus'] as num?,
  //   );
  // }

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => _$ChatUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUserModelToJson(this);

  Map<String, String> toBody() =>
      toJson().map((key, value) => value == null ? MapEntry(key, 'null') : MapEntry(key, value));


  ChatUserModel copyWith({
    ProviderRef? ref,
    num? userId,
    String? roomIcon,
    num? cohesionLevel,
    num? userCount,
    num? isOnline,
    String? userName,
    num? roomId,
    String? roomName,
    num? points,
    String? remark,
    num? unRead,
    String? recentlyMessage,
    num? pinTop,
    num? timeStamp,
    String? charmCharge,
    num? notificationFlag,
    num? sendStatus ,

  }) {
    return ChatUserModel(
      ref: ref ?? this.ref,
      userId: userId ?? this.userId,
      roomIcon: roomIcon ?? this.roomIcon,
      cohesionLevel: cohesionLevel ?? this.cohesionLevel,
      userCount: userCount ?? this.userCount,
      isOnline: isOnline ?? this.isOnline,
      userName: userName ?? this.userName,
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      points: points ?? this.points,
      remark: remark ?? this.remark,
      unRead: unRead ?? this.unRead,
      recentlyMessage: recentlyMessage ?? this.recentlyMessage,
      pinTop: pinTop ?? this.pinTop,
      timeStamp: timeStamp ?? this.timeStamp,
      charmCharge: charmCharge ?? this.charmCharge,
      notificationFlag: notificationFlag ?? this.notificationFlag,
      sendStatus: sendStatus?? this.sendStatus,
    );
  }
}
