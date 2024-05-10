import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final IconData? icon;
  final VoidCallback? onPressed;
  const CustomListTile({Key? key, this.title, this.icon, this.onPressed, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed ?? () {},
          leading: Icon(icon, color: AppColors.primaryColor),
          title: Text(
            title!,
            style: TextStyle(
              color: AppColors.primaryWhite,
            ),
          ),
          subtitle: Text(
            subTitle!,
            style: TextStyle(
              color: AppColors.grey,
            ),
          ),
        ),
        Divider(
          color: AppColors.mainColor,
          thickness: 1,
          endIndent: 30,
          indent: 30,
        )
      ],
    );
  }
}
