
// Importing the necessary packages
import 'package:flutter/material.dart';
import 'onBoarding.dart';

void main() {
 // Running the app
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    // Returning the MaterialApp widget
    return MaterialApp(
      // Disabling the debug banner
      debugShowCheckedModeBanner: false,
      // Setting the theme for the app
      theme: ThemeData(
        // Setting the primary color for the app
        primarySwatch: Colors.yellow,
        // Setting the background color for the app
        scaffoldBackgroundColor: Colors.black
      ),
      // Setting the home screen of the app
      home: Onboarding(),
    );
 }
}
//
//In this code, we have a `StatelessWidget` called `MyApp`. This widget is