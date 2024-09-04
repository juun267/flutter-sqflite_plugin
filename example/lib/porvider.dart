
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_plugin_example/model/chat_user_model.dart';

final chatUserModelProvider = Provider<ChatUserModel>((ref){
  return ChatUserModel(ref: ref);
});