import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "SmartMart",
      style: GoogleFonts.acme(
        fontSize: 42,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w900,
      ),
    ));
  }
}
