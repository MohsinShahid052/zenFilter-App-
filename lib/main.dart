import 'package:flutter/material.dart';
<<<<<<< HEAD
//import 'package:zenfilter/onBoarding%20Screens/onBoarding.dart';
//import './Dashboard/dashboard.dart';
//import './pages/about.dart';
import './pages/customerSupport.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
=======
import "./onBoarding Screens/onBoarding.dart";
//import './Dashboard/dashboard.dart';
//import './pages/about.dart';
>>>>>>> 4e843dd087a2fa91dc5ea81c32aced89384b2164

Future main() async {
  await dotenv.load(fileName: ".env");
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
          fontFamily: "Ubuntu"),
      home: const CustomerSupport(),
    );
  }
}
