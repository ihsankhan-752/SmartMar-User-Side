import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const PrimaryButton({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title!,
            style: AppTextStyles().subHeading.copyWith(
                  color: AppColors.primaryWhite,
                ),
          ),
        ),
      ),
    );
  }
}

class SocialSignInButton extends StatelessWidget {
  final String? image;
  final String? title;

  const SocialSignInButton({
    Key? key,
    this.title,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          SvgPicture.asset(
            image!,
            width: 25,
            height: 25,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            title!,
            style: AppTextStyles().subHeading.copyWith(color: AppColors.primaryBlack, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

class IncrementDecrementButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  const IncrementDecrementButton({super.key, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: 22,
        width: 25,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(05),
        ),
        child: Center(
          child: Icon(icon, size: 15, color: AppColors.primaryBlack),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final double? width, height;
  final Color? btnColor;
  final String? title;
  final Color? textColor;
  final Function()? onPressed;
  const SmallButton({super.key, this.width, this.btnColor, this.title, this.textColor, this.onPressed, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: height ?? 40,
        width: width,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title!,
            style: AppTextStyles().H2.copyWith(
                  fontSize: 12,
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }
}
