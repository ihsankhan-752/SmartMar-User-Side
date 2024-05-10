import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';

class ProductReviewPortion extends StatelessWidget {
  final dynamic productInfo;
  const ProductReviewPortion({Key? key, this.productInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: Icon(Icons.arrow_drop_down, color: AppColors.primaryWhite),
      title: Text("Review",
          style: AppTextStyles.FASHION_STYLE.copyWith(
            color: AppColors.primaryWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
      children: [
        Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("products").doc(productInfo["pdtId"]).collection("review").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "This Product is Not Review Yet",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                      fontSize: 22,
                      color: Colors.blueGrey,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var userData = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(userData['customerImage']),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData['customerName'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                userData['comment'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.grade, size: 20, color: Colors.yellow),
                          Text(
                            userData['rating'].toString(),
                            style: TextStyle(
                              color: Colors.yellowAccent,
                            ),
                          )
                        ],
                      ),
                      Divider(color: AppColors.primaryColor, thickness: 0.5),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
