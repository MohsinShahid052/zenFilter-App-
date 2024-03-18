import 'package:flutter/material.dart';
import 'package:zenFilter/config/palette.dart';
import "package:zenFilter/forgotPassword/forgotPassword.dart";

import 'package:zenFilter/login_signup/loginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  bool isPasswordVisible = false;
  bool isRememberMe = false;

  Widget buildLoginTextField(IconData icon, String hintText,
      TextEditingController controller, bool isPassword,
      {bool isEmail = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Palette.textColor1),
        obscureText: isPassword && !isPasswordVisible,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Palette.iconColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          if (isEmail && !isValidEmail(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return GestureDetector(
      onTap: _validateFieldsAndNavigate,
      child: Center(
        child: Container(
          height: 45,
          width: 150,
          padding: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
            ],
          ),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailTextController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFieldsAndNavigate() {
    String username = _usernameController.text;
    String email = _emailTextController.text;
    String password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorMessage('Please fill in all fields.');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showErrorMessage('Please enter a valid email address.');
      return;
    }

    if (password.length < 8) {
      _showErrorMessage('Password should be at least 8 characters long.');
      return;
    }

    // _signUp();
  }

  void _showErrorMessage(String errorMessage) {
    if (errorMessage.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black, // Setting background color
            title: Text(
              'Error',
              style: TextStyle(
                  color: const Color(0xFFF79817)), // Setting text color
            ),
            content: Text(
              errorMessage,
              style: TextStyle(
                  color: const Color(0xFFF79817)), // Setting text color
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.orange), // Setting text color
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _showSuccessMessage(String successMessage) {
    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            // AlertDialog content for success message
            // Similar to the error message dialog, but display success message
            );
      },
    );
  }

  // void _signUp() async {
  //   setState(() {
  //     isSigningUp = true;
  //   });

  //   String username = _usernameController.text;
  //   String email = _emailTextController.text;
  //   String password = _passwordController.text;

  //   User? user = await _auth.signUpWithEmailAndPassword(email, password);

  //   setState(() {
  //     isSigningUp = false;
  //   });

  //   if (user != null) {
  //     print("User is successfully created");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               LoginPage()), // Replace YourHomePage with your intended home page
  //     );
  //   } else {
  //     print("Some error happened");
  //   }
  // }

  Container SignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildLoginTextField(Icons.account_circle_outlined, 'User Name',
              _usernameController, false),
          buildLoginTextField(
              Icons.email_outlined, 'Email', _emailTextController, false,
              isEmail: true),
          buildLoginTextField(
              Icons.lock, 'Password', _passwordController, true),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10, left: 10),
          //   child: Row(
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             isMale = true;
          //           });
          //         },
          //         child: Row(
          //           children: [
          //             Container(
          //               width: 30,
          //               height: 30,
          //               margin: EdgeInsets.only(right: 8),
          //               decoration: BoxDecoration(
          //                   color: isMale
          //                       ? Palette.textColor2
          //                       : Colors.transparent,
          //                   border: Border.all(
          //                       width: 1,
          //                       color: isMale
          //                           ? Colors.transparent
          //                           : Palette.textColor1),
          //                   borderRadius: BorderRadius.circular(15)),
          //               child: Icon(
          //                 Icons.account_circle_outlined,
          //                 color: isMale ? Colors.white : Palette.iconColor,
          //               ),
          //             ),
          //             Text(
          //               "Male",
          //               style: TextStyle(color: Palette.textColor1),
          //             )
          //           ],
          //         ),
          //       ),
          //       SizedBox(
          //         width: 30,
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             isMale = false;
          //           });
          //         },
          //         child: Row(
          //           children: [
          //             Container(
          //               width: 30,
          //               height: 30,
          //               margin: EdgeInsets.only(right: 8),
          //               decoration: BoxDecoration(
          //                   color: isMale
          //                       ? Colors.transparent
          //                       : Palette.textColor2,
          //                   border: Border.all(
          //                       width: 1,
          //                       color: isMale
          //                           ? Palette.textColor1
          //                           : Colors.transparent),
          //                   borderRadius: BorderRadius.circular(15)),
          //               child: Icon(
          //                 Icons.account_circle_outlined,
          //                 color: isMale ? Palette.iconColor : Colors.white,
          //               ),
          //             ),
          //             Text(
          //               'Female',
          //               style: TextStyle(color: Palette.textColor1),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By pressing 'Submit' you agree to our ",
                style: TextStyle(color: Palette.textColor2),
                children: [
                  TextSpan(
                    //recognizer: ,
                    text: "term & conditions",
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//  bool isValidEmail(String email) {
//   final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//   return emailRegex.hasMatch(email);
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF79817),
      body: Stack(
        children: [
          _buildSignInSection(), // Use the function to return the sign-in section widget
        ],
      ),
    );
  }

  Widget _buildSignInSection() {
    return Scaffold(
      backgroundColor: const Color(0xFFF79817),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/logo3.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color.fromARGB(255, 3, 3, 3).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome to",
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: const Color(0xFFF79817),
                        ),
                        children: [
                          TextSpan(
                            text: " Zenfilter",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF79817),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Sign up to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            child: Container(
              height: 370,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orangeAccent.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Column(
                          children: [
                            Text(
                              'SIGNUP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFF79817),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              height: 2,
                              width: 55,
                              color: const Color(0xFFF79817),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SignupSection(),
                  SizedBox(height: 20), // Added spacing
                  buildBottomHalfContainer(false), // Your submit button
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 85,
            right: 0,
            left: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Define your navigation logic to go to the signup page here
                    // For example:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text("Already have an Account? LOGIN",
                      style: TextStyle(
                          color: Color.fromARGB(255, 10, 10, 10),
                          fontSize: 16)),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTextButton(
                          Icons.facebook, "Facebook", Palette.facebookColor),
                      buildTextButton(
                          'images/google.png', "Google", Color(0xFFDE4B39)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextButton(dynamic icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () => {print("Hello World!!")},
      style: TextButton.styleFrom(
        side: BorderSide(width: 1, color: Colors.grey),
        minimumSize: Size(145, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // primary: Colors.white,
        backgroundColor: backgroundColor,
      ),
      child: Row(
        children: [
          if (icon is IconData) // Check if the icon is an IconData
            Icon(
              icon,
            ),
          if (icon
              is String) // Check if the icon is a String (assumed to be an asset path)
            Image.asset(
              icon,
              width: 30, // Adjust width and height as needed
              height: 25,
              // Other properties as required for the image-based icon
            ),
          SizedBox(width: 5),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
