import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:zenFilter/config/palette.dart";
import 'package:zenFilter/Dashboard/dashboard.dart';
import 'package:zenFilter/forgotPassword/forgotPassword.dart';
import 'package:zenFilter/login_signup/loginPage.dart';
import 'package:zenFilter/firebaseAuthentication/firebaseAuth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  final databaseReference = FirebaseDatabase.instance.ref('User Details');
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

    if (!RegExp(r'^[a-z0-9](\.?[a-z0-9]){5,}@gmail\.com$').hasMatch(email)) {
      _showErrorMessage('Please enter a valid email address.');
      return;
    }

    if (password.length < 8) {
      _showErrorMessage('Password should be at least 8 characters long.');
      return;
    }

    _signUp();
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
            );
      },
    );
  }

  void _signUp() async {
  try {
    String username = _usernameController.text;
    String email = _emailTextController.text;
    String password = _passwordController.text;
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    String userId = userCredential.user!.uid;
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('Users').child(userId);
    userRef.set({
      'username': username,
      'email': email,
      'password': password,
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your desired page
    );
  } catch (e) {
    print('Error signing up: $e');
  }
}
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
                      buildGoogleSignInButton(context),
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

  Future<void> _signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()), 
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign-in with Google failed'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign-in with Google cancelled'),
      ));
    }
  } catch (e) {
    print('Error signing in with Google: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error signing in with Google: $e'),
    ));
  }
}

  Widget buildGoogleSignInButton(BuildContext context) {
    return TextButton(
      onPressed: () => _signInWithGoogle(context),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(width: 1, color: Colors.grey),
        minimumSize: Size(145, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.red, // Set your desired background color
      ),
      child: Row(
        children: [
          Image.asset(
            'images/google.png', // Replace with your Google logo asset path
            width: 24, // Adjust width as needed
            height: 24, // Adjust height as needed
            // Other properties for the image
          ),
          SizedBox(width: 5),
          Text(
            'Sign in with Google',
          ),
        ],
      ),
    );
  }
}
