import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class CustomerSideTextWidget extends StatelessWidget {
  const CustomerSideTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      child: Center(
        child: Text(
          "Customer Side",
          style: AppTextStyles.MAIN_SPLASH_HEADING.copyWith(fontSize: 16, color: Colors.yellow),
        ),
      ),
    );
  }
}
