import 'package:flutter/material.dart';
import 'package:zenFilter/bridge.dart'; // Importing the bridge.dart file assuming it contains the screen you want to navigate to.

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.cloud_off,
                    color: Colors.white,
                    size: 80,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Ooops!!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Montserrat', // Set font family to Montserrat
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "No internet connection was found. Check your connection or try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Montserrat', // Set font family to Montserrat
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the bridge.dart screen when the button is pressed.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BridgeOfApp(), // Replace BridgeScreen() with the actual name of your screen.
                        ),
                      );
                    },
                    child: Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
