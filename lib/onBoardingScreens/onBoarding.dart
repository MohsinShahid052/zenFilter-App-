import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'content_model.dart';
import "package:zenFilter/bridge.dart";

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
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BridgeOfApp(),
                  ),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: const Color(0xFFF79817),
                  fontSize: 18,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ),
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
                      Lottie.asset(
                        contents[i].animationAsset,
                        height: 300,
                      ),
                      Text(
                        contents[i].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: "Montserrat",
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
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BridgeOfApp(),
                    ),
                  );
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color(0xFFF79817),
              ),
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "Montserrat",
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
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF79817),
      ),
    );
  }
}
