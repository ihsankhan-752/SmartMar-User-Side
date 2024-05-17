import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  String? comment;
  int? rating;
  String? userId;
  String? userName;
  String? userImage;
  DateTime? ratingDate;

  RatingModel({
    this.rating,
    this.comment,
    this.userId,
    this.userImage,
    this.userName,
    this.ratingDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment': this.comment,
      'rating': this.rating,
      'userId': this.userId,
      'userName': this.userName,
      'userImage': this.userImage,
      'ratingDate': ratingDate,
    };
  }

  factory RatingModel.fromMap(DocumentSnapshot map) {
    return RatingModel(
      comment: map['comment'] as String,
      rating: map['rating'] as int,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
      ratingDate: (map['ratingDate'].toDate()),
    );
  }
}
