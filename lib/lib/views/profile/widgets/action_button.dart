import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';

class ActionButton extends StatelessWidget {
  final String? actionTitle;
  final Color? btnColor;
  final Function()? onPressed;
  const ActionButton({Key? key, this.actionTitle, this.btnColor, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 35,
      minWidth: 100,
      color: btnColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          actionTitle!,
          style: TextStyle(
            color: AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}
