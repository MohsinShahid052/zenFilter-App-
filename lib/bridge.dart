import 'package:flutter/material.dart';
import 'package:zenFilter/internetConnect/InternetConnection.dart';
import 'package:zenFilter/login_signup/loginPage.dart';


class BridgeOfApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:
            Colors.black, // Sets the background color of the Scaffold
        body: Center(
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              _buildCard(
                context,
                icon: Icons.web,
                color: Colors.blue,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InternetConnectivityScreen()),
                ),
                title: 'Browser',
              ),
              _buildCard(
                context,
                icon: Icons.login,
                color: Colors.green,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                title: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required Color color,
      required Function() onTap,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[
            900], // Makes the card background blend better with the app's background
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 80, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
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
