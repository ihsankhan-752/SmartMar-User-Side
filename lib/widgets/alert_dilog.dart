import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

Future<void> customAlertDialogBox({
  BuildContext? context,
  String? title,
  String? content,
  VoidCallback? plusBtnClicked,
  VoidCallback? negativeBtnClicked,
}) {
  return showDialog(
    context: context!,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Text(
          title!,
          style: TextStyle(
            color: AppColors.primaryBlack,
          ),
        ),
        content: Text(
          content!,
          style: TextStyle(
            color: AppColors.primaryBlack,
          ),
        ),
        actions: [
          CupertinoActionSheetAction(onPressed: negativeBtnClicked!, child: Text("No")),
          CupertinoActionSheetAction(onPressed: plusBtnClicked!, child: Text("Yes")),
        ],
      );
    },
  );
}
