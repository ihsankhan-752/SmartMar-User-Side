import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/product_card.dart';

import '../../../../constants/colors.dart';

class GetProductByCategory extends StatelessWidget {
  final String category;
  final String searchText;
  const GetProductByCategory({Key? key, required this.category, required this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: category == "All"
          ? FirebaseFirestore.instance.collection("products").snapshots()
          : FirebaseFirestore.instance.collection("products").where("category", isEqualTo: category).snapshots(),
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

        List<DocumentSnapshot> filteredDocs = snapshot.data!.docs.where((doc) {
          ProductModel productModel = ProductModel.fromMap(doc);
          return searchText.isEmpty || productModel.pdtName!.toLowerCase().contains(searchText.toLowerCase());
        }).toList();

        if (filteredDocs.isEmpty) {
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
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: filteredDocs.length,
          itemBuilder: (context, index) {
            ProductModel productModel = ProductModel.fromMap(filteredDocs[index]);
            return ProductCard(productModel: productModel);
          },
        );
      },
    );
  }
}
