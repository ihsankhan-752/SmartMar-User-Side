import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? fromUserId;
  String? toUserId;
  String? title;
  String? body;
  DateTime? createdAt;

  NotificationModel({
    this.fromUserId,
    this.toUserId,
    this.title,
    this.body,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'fromUserId': this.fromUserId,
      'toUserId': this.toUserId,
      'title': this.title,
      'body': this.body,
      'createdAt': this.createdAt,
    };
  }

  factory NotificationModel.fromMap(DocumentSnapshot map) {
    return NotificationModel(
      fromUserId: map['fromUserId'] as String,
      toUserId: map['toUserId'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      createdAt: (map['createdAt'].toDate()),
    );
  }
}
