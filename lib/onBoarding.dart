import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:zenfilter/login.dart';
import 'package:zenfilter/content_model.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        contents[i].image,
                        height: 300,
                      ),
                      Text(
                        contents[i].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Login(),
                    ),
                  );
                }
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20, // Set the desired font size here
                  color: Colors.black, // Set the text color to black
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.yellow,
      ),
    );
  }
}
//
//In this code, we have a `StatefulWidget` called `Onboarding` that contains a `State` object called `_OnboardingState`. The `State` object is responsible for managing the state of the widget.
//
//Inside the `_OnboardingState` class, we have a variable called `currentIndex` that keeps track of the current index of the onboarding screen. We also have a `PageController` called `_controller` that is used to control the page view.
//
//The `build` method of the `_OnboardingState` class returns a `Scaffold` widget. Inside the `Scaffold`, we have a `Column` widget that contains an `Expanded` widget, a `Container` widget for the dots, and another `Container` widget for the "Continue" or "Next" button.
//
//The `Expanded` widget contains a `PageView.builder` widget that builds the onboarding screens. The `PageView.builder` widget takes a `PageController` and an `itemCount` as parameters. The `itemCount` is the number of onboarding screens, which is the length of the `contents` list.
//
//The `buildDot` method is used to build the dots that indicate the current onboarding screen. It takes the index of the dot and the `BuildContext` as parameters.
//
//The "Continue" or "Next" button is an `ElevatedButton` widget that navigates to the `Login` screen when the last onboarding screen is displayed. Otherwise, it moves to the next onboarding screen.
//
//This code is well-commented and should provide a clear understanding of how it works.