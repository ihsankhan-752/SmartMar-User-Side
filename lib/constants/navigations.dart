import 'package:flutter/material.dart';

Future<void> navigateToPageWithPush(BuildContext context, Widget page) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

void navigateWithPushNamed(BuildContext context, String route, dynamic argument) {
  Navigator.of(context).pushNamed(route, arguments: argument);
}
