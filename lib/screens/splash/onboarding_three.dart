import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../constants/navigations.dart';
import '../../widgets/buttons.dart';
import '../auth/login_screen.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 1;
    double width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/3.png'),
            filterQuality: FilterQuality.high,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: height * 0.3,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff262a2a).withOpacity(0.95),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Smart discover your",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: AppColors.primaryWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "unique fashion ",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " style",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: AppColors.primaryWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Get Exclusive limited Apparel that only \n you have Made by famous brand",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.primaryWhite.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 30),
                    PrimaryButton(
                      onTap: () {
                        navigateToPageWithPush(context, LoginScreen());
                      },
                      title: "Get Started",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
