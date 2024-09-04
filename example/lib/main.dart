
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xu_sqflite_plugin/xu_sqflite_plugin.dart';
import 'package:xu_sqflite_plugin_example/model/chat_message_model.dart';
import 'package:xu_sqflite_plugin_example/provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
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
    final res = await ref.read(chatMessageModelProvider).insert(
        setType: SetDatabaseType.insert,
        models: [ChatMessageModel(messageUuid: '1', senderName: 'jacky')]
    );
    print('insert res: $res');
  }

  Future<List<Map<String, dynamic>>> selectChatUser() async {
    final res = await ref.read(chatMessageModelProvider).selectMatching();
    print('selectMatching res: $res');
    selectRes = res;
    setState(() {});
    return res;
  }

  Future<void> updateChatUser() async {
    final res = await ref.read(chatMessageModelProvider).update(
        updateModel: ChatMessageModel(messageUuid: '1', content: '234'),
        whereModel: ChatMessageModel(messageUuid: '1')
    );
    print('update res: $res');
  }

  Future<void> deleteChatUser() async {
    final res = await ref.read(chatMessageModelProvider).delete(
      // whereModel: ChatUserModel(userID: 333),
    );
    print('delete res: $res');
  }
}
