import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';

class NoProductFoundInWishlistWidget extends StatelessWidget {
  const NoProductFoundInWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * .2),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 250,
              child: Image.asset('assets/images/nowish.png'),
            ),
            SizedBox(height: 20),
            Text(
              "No Product Found\nIn Wishlist",
              textAlign: TextAlign.center,
              style: AppTextStyles().H2.copyWith(fontSize: 22, color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
