import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/pdt_detail_widgets/bottom_portion.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/pdt_detail_widgets/item_desc_widget_pdt_detail.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/pdt_detail_widgets/product_information_widget.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/pdt_detail_widgets/product_review_portion.dart';

import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productInfo;

  const ProductDetailScreen({this.productInfo});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List wishlist = [];
  int cartLength = 0;
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  getUserData() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      wishlist = snap['wishlist'];
      cartLength = snap['cart'].length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> imageList = widget.productInfo['productImages'];

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(widget.productInfo['pdtName']!, style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Swiper(
                  pagination: SwiperPagination(
                    builder: SwiperPagination.fraction,
                  ),
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(imageList[index], fit: BoxFit.fill)),
                    );
                  },
                ),
              ),
              ProductInformationWidget(productInfo: widget.productInfo),
              Divider(color: AppColors.primaryColor, thickness: 1),
              ItemDescWidgetProductDetail(data: widget.productInfo),
              Divider(color: AppColors.primaryColor, thickness: 1),
              ProductReviewPortion(productInfo: widget.productInfo),
            ],
          ),
        ),
      ),
      bottomSheet: BottomPortion(productInfo: widget.productInfo),
    );
  }
}
