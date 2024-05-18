import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/constants/rating_ftn.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/rating_users.dart';

import '../../../../../constants/colors.dart';

class ProductInformationWidget extends StatefulWidget {
  final ProductModel productModel;
  const ProductInformationWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductInformationWidget> createState() => _ProductInformationWidgetState();
}

class _ProductInformationWidgetState extends State<ProductInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          StreamBuilder<RatingInfo>(
              stream: getAverageRatingStream(widget.productModel.pdtId!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }

                double _avg = snapshot.data?.averageRating ?? 0.0;
                int _total = snapshot.data?.totalReviews ?? 0;

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return UserRatingWidget(productId: widget.productModel.pdtId!);
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        widget.productModel.pdtName!,
                        style: GoogleFonts.acme(
                          textStyle: TextStyle(
                            fontSize: 22,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      _avg == 0.0 ? SizedBox() : Icon(Icons.grade, size: 25, color: AppColors.amber),
                      SizedBox(width: 05),
                      _avg == 0.0
                          ? SizedBox()
                          : Text(
                              "${_avg.toStringAsFixed(1)}/5 ($_total reviews)",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primaryBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                );
              }),
          SizedBox(height: 15),
          Text(
            "${widget.productModel.pdtDescription}",
            style: TextStyle(
              color: AppColors.primaryBlack.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
