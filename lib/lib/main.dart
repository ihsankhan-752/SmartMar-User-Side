import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/lib/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/lib/controllers/user_controller.dart';
import 'package:smart_mart_user_side/lib/utils/services/stripe_services.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/custom_bottom_navigation_bar.dart';
import 'package:smart_mart_user_side/lib/views/splash/onboarding_one.dart';
import 'package:smart_mart_user_side/lib/views/splash/splash_screen.dart';

import 'controllers/cart_controller.dart';
import 'controllers/wishlist_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/main_splash',
        routes: {
          splash_screen.routeName: (_) => splash_screen(),
          OnBoardingOne.routeName: (_) => OnBoardingOne(),
          CustomBottomNavigation.routeName: (_) => CustomBottomNavigation(),
        },
        home: splash_screen(),
        // home: HomeScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
