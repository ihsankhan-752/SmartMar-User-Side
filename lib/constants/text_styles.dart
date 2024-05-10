import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyles {
  TextStyle H1 = GoogleFonts.patuaOne(
    fontSize: 32,
    color: Colors.white,
  );
  TextStyle H2 = GoogleFonts.patuaOne(
    fontSize: 32,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  TextStyle subHeading = GoogleFonts.acme(
    fontSize: 16,
    color: Colors.white,
  );
  static TextStyle MAIN_SPLASH_HEADING = GoogleFonts.pacifico(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 45,
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
  );
  static TextStyle FASHION_STYLE = TextStyle(
    color: AppColors.primaryWhite,
    fontSize: 22,
  );
  static TextStyle APPBAR_HEADING_STYLE = GoogleFonts.acme(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 0.8,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
  static TextStyle TAB_BAR_ITEM_STYLE = GoogleFonts.acme(
    textStyle: TextStyle(
      letterSpacing: 0.8,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
}
