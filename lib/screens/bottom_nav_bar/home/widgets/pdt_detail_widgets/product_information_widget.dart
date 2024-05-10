import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/colors.dart';
import '../../../../../services/firestore_services.dart';

class ProductInformationWidget extends StatefulWidget {
  final dynamic productInfo;
  const ProductInformationWidget({Key? key, this.productInfo}) : super(key: key);

  @override
  State<ProductInformationWidget> createState() => _ProductInformationWidgetState();
}

class _ProductInformationWidgetState extends State<ProductInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            widget.productInfo['pdtName']!,
            style: GoogleFonts.acme(
              textStyle: TextStyle(
                fontSize: 22,
                color: AppColors.primaryColor,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.productInfo['price']!.toStringAsFixed(2)} USD",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryWhite,
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return IconButton(
                    icon: data['wishlist'].contains(widget.productInfo['pdtId'])
                        ? Icon(Icons.favorite, color: Colors.red[900])
                        : Icon(Icons.favorite_border, color: Colors.red[900]),
                    onPressed: () async {
                      await FireStoreServices().addItemToWishlist(context, widget.productInfo['pdtId']);
                      setState(() {});
                    },
                  );
                }),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "${widget.productInfo['quantity']} Pieces in Stock",
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
