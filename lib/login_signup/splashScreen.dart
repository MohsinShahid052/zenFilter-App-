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
              builder: (context) =>Onboarding()), // Replace with your home screen widget
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
          child: YourLogoWidget(), // Replace with your logo or animation widget
        ),
      ),
    );
  }
}

class YourLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your logo or animation widget here
    return Container(
      child: Text(
        'Your Logo or Animation',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
