import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ichops/screens/unboardingScreen/splash.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'constants/constraints.dart';
import 'constants/firebase.dart';
import 'controllers/authController.dart';
import 'controllers/cart_controller.dart';
import 'controllers/fav_controller.dart';
import 'controllers/payments_controller.dart';
import 'controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await initialization.then((value) {
    Get.put(UserController());
    Get.put(FoodController());
    Get.put(DrinksController());
    Get.put(SnacksController());
    Get.put(MeatController());
    Get.put(OthersController());
    Get.put(CartController());
    Get.put(FavouriteController());
    Get.put(CartPaymentsController());
    Get.put(FavPaymentsController());
  });
  runApp(IChops());
}

class IChops extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 400,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(400, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      defaultTransition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 100),
      debugShowCheckedModeBanner: false,
      title: 'Ichops',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: myPrimaryColor,
        accentColor: myPrimaryColor,
        primarySwatch: Colors.lightBlue,
      ),
      home: Splash(),
    );
  }
}
