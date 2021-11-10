import 'package:flutter/material.dart';
import 'package:ichops/models/unboardingModel.dart';

import 'onboardingUI.dart';

final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

class StartOnboarding extends StatefulWidget {
  const StartOnboarding({Key key}) : super(key: key);

  @override
  _StartOnboardingState createState() => _StartOnboardingState();
}

class _StartOnboardingState extends State<StartOnboarding>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OnboardingUI(
        bgColor: Colors.white,
        themeColor: const Color(0xDCDF5A0D),
        pages: pages,
        skipClicked: (value) {
          print(value);
        },
        getStartedClicked: (value) {
          print(value);
        },
      ),
    );
  }

  final pages = [
    OnboardingModel(
        title: 'Welcome to iChops',
        description: 'We deliver right on time.',
        titleColor: const Color(0xDCDF5A0D),
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/icons/onboarding1.png'),
    OnboardingModel(
        title: 'Enjoy your time with us',
        description: 'Our orders are fast and simple',
        titleColor: const Color(0xDCDF5A0D),
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/icons/onboarding2.png'),
    OnboardingModel(
        title: 'Pay quick and easy',
        description: 'Pay for order using credit or debit card',
        titleColor: const Color(0xDCDF5A0D),
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/icons/onboarding3.png'),
  ];
}
