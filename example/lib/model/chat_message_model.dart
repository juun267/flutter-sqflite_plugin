import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xu_sqflite_plugin/xu_sqflite_plugin.dart';

class ChatMessageModel extends SQFLiteHandler implements SQFLiteBaseTable {
  final ProviderRef? ref;
  final String? messageUuid; //uuid
  final num? senderId; //發送人ID
  final num? receiverId; //接收人ID
  final String? senderName; //發送人Name
  final String? receiverName; //接收人Name
  final num? groupId; //群組ID
  final String? content; //內容
  final num? timeStamp; //時間戳
  final num? isGroupMessage; //是否為群組訊息
  final num? isDeleted; //單筆删除
  final num? mediaId;
  final num? gender; //性別
  final num? expireTime; //完整收費截止時間
  final num? halfTime; //收費一半截止時間
  final num? points; //每則收費
  final num? incomeflag; //0:免費 1:照規則走
  final num? remainCoins; //剩餘金币
  /// 類型：0(文字)、1(圖片)、2(錄音)、3(禮物)、4(通話紀錄)
  /// 封鎖類型：5(文字)、6(圖片)、7(錄音)、8(禮物)、9(通話紀錄)
  final num? type;
  final num? chargeType; //是否已收費狀態
  final num? chargeCoin; //收費金币
  final num? unRead; //是否已讀
  final num? expireDuration; //收益逾期時長(分鐘)
  final num? halfDuration; //收益減半時常(分鐘)
  /// 類型：0(通过)、1( 未通过)
  final num? reviewStatus; //审查状态
  final String? testStr;

  ChatMessageModel({
    this.ref,
    this.messageUuid,
    this.senderId,
    this.receiverId,
    this.senderName,
    this.receiverName,
    this.groupId,
    this.content,
    this.timeStamp,
    this.isGroupMessage,
    this.isDeleted,
    this.mediaId,
    this.gender,
    this.expireTime,
    this.halfTime,
    this.points,
    this.incomeflag,
    this.remainCoins,
    this.chargeType,
    this.chargeCoin,
    this.type,
    this.unRead,
    this.expireDuration,
    this.halfDuration,
    this.reviewStatus,
    this.testStr,
  });

  @override
  String get createTableSql =>
      SQFLiteDDLUtil.create(model: ChatMessageModel(ref: ref));

  @override
  int get databaseVersion => 2;

  @override
  String get tableName => 'ChatMessageModel';

  @override
  List<SQFLiteColumnModel> get columns => [
    SQFLiteColumnModel(name: 'messageUuid', type: String, isPrimaryKey: true),
    SQFLiteColumnModel(name: 'senderId', type: num, foreignKey: 'ChatUserModel(userId)'),
    SQFLiteColumnModel(name: 'receiverId', type: num, foreignKey: 'ChatUserModel(userId)'),
    SQFLiteColumnModel(name: 'senderName', type: String, foreignKey: 'ChatUserModel(senderName)'),
    SQFLiteColumnModel(name: 'receiverName', type: String, foreignKey: 'ChatUserModel(receiverName)'),
    SQFLiteColumnModel(name: 'groupId', type: num, foreignKey: 'ChatGroupModel(groupId)'),
    SQFLiteColumnModel(name: 'content', type: String),
    SQFLiteColumnModel(name: 'timeStamp', type: num),
    SQFLiteColumnModel(name: 'isGroupMessage', type: bool),
    SQFLiteColumnModel(name: 'isDeleted', type: num),
    SQFLiteColumnModel(name: 'gender', type: num),
    SQFLiteColumnModel(name: 'expireTime', type: num),
    SQFLiteColumnModel(name: 'halfTime', type: num),
    SQFLiteColumnModel(name: 'points', type: num),
    SQFLiteColumnModel(name: 'incomeflag', type: num),
    SQFLiteColumnModel(name: 'remainCoins', type: num),
    SQFLiteColumnModel(name: 'chargeType', type: num),
    SQFLiteColumnModel(name: 'chargeCoin', type: num),
    SQFLiteColumnModel(name: 'type', type: num),
    SQFLiteColumnModel(name: 'unRead', type: num),
    SQFLiteColumnModel(name: 'expireDuration', type: num),
    SQFLiteColumnModel(name: 'halfDuration', type: num),
    SQFLiteColumnModel(name: 'reviewStatus', type: num),
    SQFLiteColumnModel(name: 'mediaId', type: num, foreignKey: 'ChatMediaModel(mediaId)'),
    SQFLiteColumnModel(name: 'testStr', type: String),
  ]; // testStr

  @override
  Map<String, dynamic> toMap() {
    return {
      'messageUuid': messageUuid,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': senderName,
      'receiverName': receiverName,
      'groupId': groupId,
      'content': content,
      'timeStamp': timeStamp,
      'isGroupMessage': isGroupMessage,
      'isDeleted': isDeleted,
      'mediaId': mediaId,
      'remainCoins': remainCoins,
      'gender': gender,
      'expireTime': expireTime,
      'halfTime': halfTime,
      'points': points,
      'incomeflag': incomeflag,
      'chargeType': chargeType,
      'chargeCoin': chargeCoin,
      'type': type,
      'unRead': unRead,
      'expireDuration': expireDuration,
      'halfDuration': halfDuration,
      'reviewStatus': reviewStatus,
      'testStr': testStr
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatMessageModel(
      messageUuid: jsonData['messageUuid'] as String?,
      senderId: jsonData['senderId'] as num?,
      receiverId: jsonData['receiverId'] as num?,
      senderName: jsonData['senderName'] as String?,
      receiverName: jsonData['receiverName'] as String?,
      groupId: jsonData['groupId'] as num?,
      content: jsonData['content'] as String?,
      timeStamp: jsonData['timeStamp'] as num?,
      isGroupMessage: jsonData['isGroupMessage'] as num?,
      isDeleted: jsonData['isDeleted'] as num?,
      mediaId: jsonData['mediaId'] as num?,
      remainCoins: jsonData['remainCoins'] as num?,
      gender: jsonData['gender'] as num?,
      expireTime: jsonData['expireTime'] as num?,
      halfTime: jsonData['halfTime'] as num?,
      points: jsonData['points'] as num?,
      incomeflag: jsonData['incomeflag'] as num?,
      chargeType: jsonData['chargeType'] as num?,
      chargeCoin: jsonData['chargeCoin'] as num?,
      type: jsonData['type'] as num?,
      unRead: jsonData['unRead'] as num?,
      expireDuration: jsonData['expireDuration'] as num?,
      halfDuration: jsonData['halfDuration'] as num?,
      reviewStatus: jsonData['reviewStatus'] as num?,
      testStr: jsonData['testStr'] as String?,
    );
  }

  static String encode(ChatMessageModel chatMessageModel) =>
      json.encode(ChatMessageModel().toMap());

  static List<ChatMessageModel> decode(
      List<Map<String, dynamic>> chatMessageModel) {
    return chatMessageModel.map<ChatMessageModel>((item) {
      return ChatMessageModel.fromJson(item);
    }).toList();
  }

  ChatMessageModel copyWith({
    ProviderRef? ref,
    String? messageUuid,
    num? senderId,
    num? receiverId,
    String? senderName,
    String? receiverName,
    num? groupId,
    String? content,
    num? timeStamp,
    num? isGroupMessage,
    num? isDeleted,
    num? mediaId,
    num? gender,
    num? expireTime,
    num? halfTime,
    num? points,
    num? incomeflag,
    num? remainCoins,
    num? type,
    num? chargeType,
    num? chargeCoin,
    num? unRead,
    num? expireDuration,
    num? halfDuration,
    num? reviewStatus,
  }) {
    return ChatMessageModel(
      ref: ref ?? this.ref,
      messageUuid: messageUuid ?? this.messageUuid,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      senderName: senderName ?? this.senderName,
      receiverName: receiverName ?? this.receiverName,
      groupId: groupId ?? this.groupId,
      content: content ?? this.content,
      timeStamp: timeStamp ?? this.timeStamp,
      isGroupMessage: isGroupMessage ?? this.isGroupMessage,
      isDeleted: isDeleted ?? this.isDeleted,
      mediaId: mediaId ?? this.mediaId,
      gender: gender ?? this.gender,
      expireTime: expireTime ?? this.expireTime,
      halfTime: halfTime ?? this.halfTime,
      points: points ?? this.points,
      incomeflag: incomeflag ?? this.incomeflag,
      remainCoins: remainCoins ?? this.remainCoins,
      type: type ?? this.type,
      chargeType: chargeType ?? this.chargeType,
      chargeCoin: chargeCoin ?? this.chargeCoin,
      unRead: unRead ?? this.unRead,
      expireDuration: expireDuration ?? this.expireDuration,
      halfDuration: halfDuration ?? this.halfDuration,
      reviewStatus: reviewStatus ?? this.reviewStatus,
    );
  }
}
