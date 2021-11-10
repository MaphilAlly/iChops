import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import 'package:ichops/constants/constraints.dart';
import 'package:ichops/screens/authentication/widgets/loginPage.dart';

import 'package:ichops/screens/unboardingScreen/start_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

// ignore: camel_case_types
class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      gradientBackground: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.5, 1.0],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          myPrimaryColor,
          Colors.white,
        ],
      ),
      seconds: 3,
      navigateAfterSeconds: CheckScreen(),
      title: new Text(
        '\n\niChops',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: myBackgroundColor),
      ),
      image: Image.asset("assets/icons/icon.png"),
      photoSize: 60,
      backgroundColor: myPrimaryColor,
      loaderColor: myPrimaryColor,
    );
  }
}

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen>
    with AfterLayoutMixin<CheckScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new StartOnboarding()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
