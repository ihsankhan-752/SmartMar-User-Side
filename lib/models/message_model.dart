import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? docId;
  String? msg;
  String? senderName;
  String? senderId;
  String? senderImage;
  DateTime? createdAt;

  MessageModel({
    this.docId,
    this.msg,
    this.senderName,
    this.senderId,
    this.senderImage,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'docId': this.docId,
      'msg': this.msg,
      'senderName': this.senderName,
      'senderId': this.senderId,
      'senderImage': this.senderImage,
      'createdAt': this.createdAt,
    };
  }

  factory MessageModel.fromMap(DocumentSnapshot map) {
    return MessageModel(
      docId: map['docId'] as String,
      msg: map['msg'] as String,
      senderName: map['senderName'] as String,
      senderId: map['senderId'] as String,
      senderImage: map['senderImage'] as String,
      createdAt: (map['createdAt'].toDate()),
    );
  }
}
