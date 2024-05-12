import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/product_card.dart';

import '../../../../constants/colors.dart';

class GetProductByCategory extends StatelessWidget {
  final String category;
  const GetProductByCategory({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("products").where("category", isEqualTo: category).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 180),
            child: Center(
              child: Text(
                "No Data Found!!",
                style: GoogleFonts.poppins(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          );
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            ProductModel productModel = ProductModel.fromMap(snapshot.data!.docs[index]);

            return ProductCard(productModel: productModel);
          },
        );
      },
    );
  }
}
