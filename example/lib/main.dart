import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_plugin/sqflite_plugin.dart';
import 'package:sqflite_plugin_example/model/chat_user_model.dart';
import 'package:sqflite_plugin_example/porvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  List<Map<String, dynamic>> selectRes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('sqflite'),
        ),
        body: InkWell(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: ${Platform.localHostname}', style: const TextStyle(color: Colors.red)),
              Expanded(child: _buildList()),
              const Text('Migration Btn'),
              _buildMigrationBtn(),
              const Text('CRUD Btn'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () => createChatUser(), child: Text('Create')),
                    ElevatedButton(onPressed: () => selectChatUser(), child: Text('Select')),
                    ElevatedButton(onPressed: () => updateChatUser(), child: Text('Update')),
                    ElevatedButton(onPressed: () => deleteChatUser(), child: Text('Delete')),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildMigrationBtn() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(onPressed: () => createMigrationChatUser(), child: Text('Create')),
          ElevatedButton(onPressed: () => selectMigrationChatUser(), child: Text('Select')),
          ElevatedButton(onPressed: () => updateMigrationChatUser(), child: Text('Update')),
          ElevatedButton(onPressed: () => deleteMigrationChatUser(), child: Text('Delete')),
        ],
      ),
    );
  }

  createMigrationChatUser() {

  }

  selectMigrationChatUser() async {
    final SqfliteLogModel model = SqfliteLogModel();
    final List<Map<String, dynamic>> res = await model.selectMatching();
    print('SqfliteLogModel: $res');
  }

  updateMigrationChatUser() {

  }

  deleteMigrationChatUser() {

  }

  _buildList() {
    return SingleChildScrollView(
      child: Column(
        children: selectRes.map((selectInfo) {
          return Text('${selectInfo.values}');
        }).toList(),
      ),
    );
  }

  Future<void> createChatUser() async {
    final res = await ref.read(chatUserModelProvider).insert(
        setType: SetDatabaseType.insert,
        models: [ChatUserModel()]
    );
    print('insert res: $res');
  }

  Future<List<Map<String, dynamic>>> selectChatUser() async {
    final res = await ref.read(chatUserModelProvider).selectMatching();
    print('selectMatching res: $res');
    selectRes = res;
    setState(() {});
    return res;
  }

  Future<void> updateChatUser() async {
    final res = await ref.read(chatUserModelProvider).update(
        updateModel: ChatUserModel(),
        whereModel: ChatUserModel(),
    );
    print('update res: $res');
  }

  Future<void> deleteChatUser() async {
    final res = await ref.read(chatUserModelProvider).delete(
      // whereModel: ChatUserModel(userID: 333),
    );
    print('delete res: $res');
  }
}
