import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class AuthFooter extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final String? screenName;
  const AuthFooter({super.key, this.onPressed, this.title, this.screenName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
            ),
          ),
          Text(
            "$screenName",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
