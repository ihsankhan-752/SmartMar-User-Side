import 'package:flutter/cupertino.dart';

class CustomWidgetSelection extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final Color? activeColor;
  final String? title;
  const CustomWidgetSelection({Key? key, this.onPressed, this.icon, this.activeColor, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: activeColor, size: 22),
          Text(
            title!,
            style: TextStyle(
              color: activeColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
