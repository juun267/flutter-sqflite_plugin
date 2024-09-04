
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xu_sqflite_plugin_example/model/chat_message_model.dart';


final chatMessageModelProvider = Provider<ChatMessageModel>((ref){
  return ChatMessageModel(ref: ref);
});