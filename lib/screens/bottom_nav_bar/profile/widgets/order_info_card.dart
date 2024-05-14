import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class OrderInfoCard extends StatelessWidget {
  final String? title;
  final String? value;

  const OrderInfoCard({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Text(
                "${title}:",
                style: GoogleFonts.acme(
                  fontSize: 15,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(width: 02),
              Text(
                value!,
                style: GoogleFonts.acme(
                  fontSize: 14,
                  color: AppColors.primaryWhite,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey, thickness: 0.6)
      ],
    );
  }
}
