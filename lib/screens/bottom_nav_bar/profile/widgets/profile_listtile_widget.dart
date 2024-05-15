import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/constants/text_styles.dart';

import '../../../../constants/colors.dart';

class ProfileListTileWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final IconData? icon;
  const ProfileListTileWidget({Key? key, this.title, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: onPressed ?? () {},
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(05),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: Icon(icon!, size: 18, color: AppColors.primaryColor),
              ),
            ),
            title: Text(
              title!,
              style: AppTextStyles().H2.copyWith(fontSize: 15),
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
          ),
          Divider(thickness: 0.2, height: 0.1),
        ],
      ),
    );
  }
}
