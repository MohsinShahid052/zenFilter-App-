import 'package:flutter/material.dart';
//import "./onBoarding Screens/onBoarding.dart";
import './Dashboard/dashboard.dart';
//import './pages/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF79817), // Setting the primary color
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Dashboard(),
    );
  }
}
