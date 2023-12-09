import 'package:flutter/material.dart';
//import 'package:zenfilter/onBoarding%20Screens/onBoarding.dart';
//import './Dashboard/dashboard.dart';
//import './pages/about.dart';
import './pages/customerSupport.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
