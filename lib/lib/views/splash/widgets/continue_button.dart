import 'package:flutter/material.dart';

import '../../../utils/functions/functions.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../../auth/login_screen.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
        color: AppColors.dark_grey,
      ),
      child: InkWell(
        onTap: () {
          navigateToPageWithPush(context, LoginScreen());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'CONTINUE',
              style: AppTextStyles().H2.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 120,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
