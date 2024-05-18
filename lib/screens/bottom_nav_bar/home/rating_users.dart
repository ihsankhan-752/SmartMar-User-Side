import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart ' as timeago;

import '../../../constants/colors.dart';
import '../../../models/rating_model.dart';

class UserRatingWidget extends StatelessWidget {
  final String productId;
  const UserRatingWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').doc(productId).collection('reviews').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              RatingModel ratingModel = RatingModel.fromMap(snapshot.data!.docs[index]);
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: AppColors.mainColor,
                        radius: 25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.grade, size: 12, color: AppColors.amber),
                            SizedBox(width: 05),
                            Text(
                              ratingModel.rating.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.primaryWhite,
                              ),
                            ),
                          ],
                        )),
                    title: Text(
                      ratingModel.userName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlack,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      ratingModel.comment!,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(timeago.format(ratingModel.ratingDate!)),
                  ),
                  Divider(height: 0.2, thickness: 0.5),
                ],
              );
            },
          );
        });
  }
}
