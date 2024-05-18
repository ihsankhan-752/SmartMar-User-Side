import 'package:cloud_firestore/cloud_firestore.dart';

Stream<RatingInfo> getAverageRatingStream(String docId) {
  return FirebaseFirestore.instance.collection('products').doc(docId).collection('reviews').snapshots().map((snap) {
    double sum = 0.0;
    int count = snap.size;
    for (var rating in snap.docs) {
      sum += rating['rating'];
    }
    double averageRating = count != 0 ? sum / count : 0;
    return RatingInfo(averageRating, count);
  });
}

class RatingInfo {
  final double averageRating;
  final int totalReviews;

  RatingInfo(this.averageRating, this.totalReviews);
}
