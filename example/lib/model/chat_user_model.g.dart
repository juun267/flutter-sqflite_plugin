// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUserModel _$ChatUserModelFromJson(Map<String, dynamic> json) =>
    ChatUserModel(
      userId: json['userId'] as num?,
      roomIcon: json['roomIcon'] as String?,
      cohesionLevel: json['cohesionLevel'] as num?,
      userCount: json['userCount'] as num?,
      isOnline: json['isOnline'] as num?,
      userName: json['userName'] as String?,
      roomId: json['roomId'] as num?,
      roomName: json['roomName'] as String?,
      points: json['points'] as num?,
      remark: json['remark'] as String?,
      unRead: json['unRead'] as num?,
      recentlyMessage: json['recentlyMessage'] as String?,
      pinTop: json['pinTop'] as num?,
      timeStamp: json['timeStamp'] as num?,
      charmCharge: json['charmCharge'] as String?,
      notificationFlag: json['notificationFlag'] as num?,
      sendStatus: json['sendStatus'] as num?,
    );

Map<String, dynamic> _$ChatUserModelToJson(ChatUserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'roomIcon': instance.roomIcon,
      'cohesionLevel': instance.cohesionLevel,
      'userCount': instance.userCount,
      'isOnline': instance.isOnline,
      'userName': instance.userName,
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'points': instance.points,
      'remark': instance.remark,
      'unRead': instance.unRead,
      'recentlyMessage': instance.recentlyMessage,
      'pinTop': instance.pinTop,
      'timeStamp': instance.timeStamp,
      'charmCharge': instance.charmCharge,
      'notificationFlag': instance.notificationFlag,
      'sendStatus': instance.sendStatus,
    };
