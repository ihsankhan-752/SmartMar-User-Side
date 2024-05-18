import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paymob_pakistan/paymob_payment.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/app_text_controller.dart';
import 'package:smart_mart_user_side/controllers/image_controller.dart';
import 'package:smart_mart_user_side/controllers/visibility_controller.dart';
import 'package:smart_mart_user_side/screens/splash/splash_screen.dart';

import 'constants/keys.dart';
import 'controllers/cart_controller.dart';
import 'controllers/loading_controller.dart';
import 'controllers/user_controller.dart';
import 'controllers/wishlist_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  PaymobPakistan.instance.initialize(
    apiKey: paymobKey,
    integrationID: 169470,
    iFrameID: 178836,
    jazzcashIntegrationId: 123456,
    easypaisaIntegrationID: 123456,
  );

  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => WishListController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => LoadingController()),
        ChangeNotifierProvider(create: (_) => AppTextController()),
        ChangeNotifierProvider(create: (_) => ImageController()),
        ChangeNotifierProvider(create: (_) => VisibilityController()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
