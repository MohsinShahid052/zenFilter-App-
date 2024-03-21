import 'dart:async';
import 'package:flutter/material.dart';
import "package:zenFilter/onBoardingScreens/onBoarding.dart";

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Onboarding()), // Replace with your home screen widget
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: LogoWidget(), // Replace with your logo or animation widget
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Logo's width
      height: 300, // Logo's height
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Image.asset(
        'images/zenFilterlogo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
