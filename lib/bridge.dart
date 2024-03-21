import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zenFilter/login_signup/loginPage.dart';
import 'package:zenFilter/internetConnect/adblocker.dart';

class BridgeOfApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(40), // Increase the padding
            children: <Widget>[
              _buildCard(
                context,
                title: 'Safe Browser',
                animationPath: 'assets/animationAsset/browser.json',
                color: const Color(0xFFF79817),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SiteBlockerWebView()),
                ),
                
              ),
              _buildCard(
                
                context,
                title: 'Login',
                animationPath: 'assets/animationAsset/login.json',
                color: const Color(0xFFF79817),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String animationPath,
      required Color color,
      required Function() onTap,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // Reduce the width of the Lottie animation
            Lottie.asset(animationPath,
                width: 160, height: 160, fit: BoxFit.fill),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
