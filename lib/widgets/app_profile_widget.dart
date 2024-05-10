import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_images.dart';
import '../constants/colors.dart';

class AppProfileWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const AppProfileWidget({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
        colorFilter: ColorFilter.mode(AppColors.primaryBlack.withOpacity(0.75), BlendMode.srcATop),
        image: AppImages.SPLASH_IMAGE,
        fit: BoxFit.cover,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset("assets/images/logo.png"),
          ),
          SpinKitSpinningLines(
            itemCount: 15,
            color: Colors.deepOrange,
          )
        ],
      ),
    );
  }
}
