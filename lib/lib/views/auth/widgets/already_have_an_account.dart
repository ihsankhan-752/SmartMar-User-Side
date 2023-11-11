import 'package:flutter/material.dart';

import '../../../utils/styles/app_text.dart';
import '../../../utils/styles/colors.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppText.ALREADY_ACC,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          AppText.SIGN_IN,
          style: TextStyle(
            color: Colors.purple,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
