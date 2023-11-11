import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_mart_user_side/lib/custom_widgets/custom_msg.dart';
import 'package:smart_mart_user_side/lib/custom_widgets/custom_text_fields.dart';
import 'package:smart_mart_user_side/lib/utils/styles/colors.dart';
import 'package:smart_mart_user_side/lib/utils/styles/text_styles.dart';

import '../../../custom_widgets/buttons.dart';

class OrderRatingScreen extends StatefulWidget {
  final List? pdtId;
  final String orderId;
  const OrderRatingScreen({Key? key, this.pdtId, required this.orderId}) : super(key: key);

  @override
  State<OrderRatingScreen> createState() => _OrderRatingScreenState();
}

class _OrderRatingScreenState extends State<OrderRatingScreen> {
  bool isLoading = false;
  TextEditingController ratingController = TextEditingController();
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Rating', style: AppTextStyles.APPBAR_HEADING_STYLE),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                glow: true,
                glowColor: Colors.red,
                unratedColor: AppColors.grey,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rat) {
                  setState(() {
                    rating = rat;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            AuthTextInput(
              controller: ratingController,
              hintText: 'Rate your Experience',
            ),
            SizedBox(height: 30),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PrimaryButton(
                    onTap: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });

                        for (var id in widget.pdtId!) {
                          if (ratingController.text.isNotEmpty) {
                            DocumentSnapshot snapshot = await FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get();
                            await FirebaseFirestore.instance.collection('products').doc(id).collection('review').add({
                              "customerName": snapshot['userName'],
                              "customerImage": snapshot['image'],
                              "customerUid": snapshot['uid'],
                              "rating": rating,
                              "comment": ratingController.text,
                            });
                            await FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update({
                              'orderReview': true,
                            });
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);

                            showCustomMsg(context: context, msg: 'Review Added Successfully');
                          }
                        }
                      } on FirebaseException catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        showCustomMsg(context: context, msg: e.message!);
                      }
                    },
                    title: "Save",
                  )
          ],
        ),
      ),
    );
  }
}
