import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:zenFilter/login_signup/loginPage.dart';
import 'package:zenFilter/pages/settings.dart';
import "package:zenFilter/pages/about.dart";
import "package:zenFilter/pages/preferences.dart";
import "package:zenFilter/pages/website_Block.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:zenFilter/screens/home.dart";
import 'package:zenFilter/pages/customerSupport.dart';
import "package:zenFilter/appstats/stat_screen.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:zenFilter/bridge.dart";

// Initialize the Firebase app
final FirebaseDatabase database = FirebaseDatabase.instance;
// Access the database reference
final DatabaseReference dbRef = database.reference();

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _userImagePath;
  Timer? _logoutTimer;

  String? getCurrentUserEmail() {
    return _firebaseAuth.currentUser?.email;
  }

  String? getCurrentUsername() {
    return _firebaseAuth.currentUser?.displayName;
  }

  int _currentIndex = 0;
  final List<String> imgSrc = [
    "images/p3.png",
    "images/history.png",
    "images/web.png",
    "images/phone.png",
    "images/help.png",
    "images/about.png",
  ];

  final List<String> imgNames = [
    "Preferences",
    "App Stats",
    "Block Web",
    "Block App",
    "Help",
    "About Us",
  ];

  Future<void> _loadUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userImagePath = prefs.getString('userImagePath');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Correctly add this class as an observer
    _loadUserImage();
    _startLogoutTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer on dispose
    _logoutTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _resetLogoutTimer();
    }
  }

  void _startLogoutTimer() {
    _logoutTimer = Timer(const Duration(minutes: 10), _logoutUser);
  }

  void _resetLogoutTimer() {
    if (mounted) {
      setState(() {
        _logoutTimer?.cancel();
        _startLogoutTimer();
      });
    }
  }

  @override
  Future<void> _logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              LoginPage())); // Adjust according to your LoginPage import
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? userEmail = getCurrentUserEmail();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () {
          _resetLogoutTimer();
        },
        child: Scaffold(
          body: Container(
            color: const Color(0xFFF79817),
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  // Added Text
                  const Text(
                    "Welcome to Dashboard",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Color.fromARGB(255, 10, 10, 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                      right: width * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: height * 0.08,
                            width: height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(height * 0.04),
                              color: const Color.fromARGB(255, 0, 0, 0),
                              image: DecorationImage(
                                // Use the loaded image path, fallback to a default image if null
                                image: _userImagePath != null
                                    ? FileImage(File(_userImagePath!))
                                    : const AssetImage("images/woman.png")
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              Text(
                                '$userEmail',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            _logoutUser();

                            try {
                              await FirebaseAuth.instance.signOut();
                              // Show a SnackBar with the logout message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Logged out successfully'),
                                ),
                              );
                              // Redirect to the login or home screen after logging out
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BridgeOfApp()),
                              );
                            } catch (e) {
                              print('Error logging out: $e');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(height * 0.03),
                            topRight: Radius.circular(height * 0.03),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.1,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          itemCount: imgSrc.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (imgNames[index] == "Preferences") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Preferences(),
                                    ),
                                  );
                                }
                                if (imgNames[index] == "App Stats") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StatsScreen(),
                                    ),
                                  );
                                }
                                if (imgNames[index] == "Block Web") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BlockListManagementPage(),
                                    ),
                                  );
                                }
                                if (imgNames[index] == "Block App") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                }
                                if (imgNames[index] == "About Us") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TeamHierarchyPage(),
                                    ),
                                  );
                                }
                                if (imgNames[index] == "Help") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerSupport(),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Image.asset(imgSrc[index]),
                                    ),
                                    Text(
                                      imgNames[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            color: const Color(0xFFF79817),
            buttonBackgroundColor: const Color(0xFFF79817),
            height: 50,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
                if (_currentIndex == 1) {
                  // Navigate to the dailyReport page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatsScreen(),
                    ),
                  );
                }
                if (_currentIndex == 2) {
                  // Navigate to the Settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ),
                  );
                }
              });
            },
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.bar_chart, size: 30),
              Icon(Icons.settings, size: 30),
            ],
          ),
        ));
  }
}
