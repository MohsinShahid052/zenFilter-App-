import 'package:flutter/material.dart';
import 'onBoarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFF79817), // Setting the primary color
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Onboarding(),
    );
  }
}
