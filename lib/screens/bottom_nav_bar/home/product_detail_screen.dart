import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/pdt_detail_widgets/bottom_portion.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/pdt_detail_widgets/product_information_widget.dart';
import 'package:smart_mart_user_side/services/wishlist_services.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailScreen({required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int cartLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Details", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Swiper(
                pagination: SwiperPagination(
                  builder: SwiperPagination.fraction,
                ),
                itemCount: widget.productModel.pdtImages!.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.productModel.pdtImages![index]),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Card(
                          color: AppColors.primaryWhite,
                          elevation: 3,
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                                  return IconButton(
                                    icon: data['wishlist'].contains(widget.productModel.pdtId)
                                        ? Icon(Icons.favorite)
                                        : Icon(Icons.favorite_border),
                                    onPressed: () async {
                                      await WishlistServices().addItemToWishlist(context, widget.productModel.pdtId!);
                                      setState(() {});
                                    },
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 0.2,
              color: AppColors.primaryWhite,
              child: Column(
                children: [
                  ProductInformationWidget(productModel: widget.productModel),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: BottomPortion(productModel: widget.productModel),
    );
  }
}
