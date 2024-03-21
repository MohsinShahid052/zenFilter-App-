import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenFilter/Config/Palette.dart';
import 'package:zenFilter/forgotPassword/forgotPassword.dart';
import 'package:zenFilter/Login_signup/SignupPage.dart';
import 'package:zenFilter/firebaseAuthentication/firebaseAuth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:zenFilter/Dashboard/dashboard.dart";

class ForgotPasswordBtnWidget extends StatelessWidget {
  const ForgotPasswordBtnWidget({
    required this.btnIcon,
    required this.subtitle,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData btnIcon;
  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFF79817),
        ),
        child: Row(
          children: [
            Icon(btnIcon, size: 60.0),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isSigning = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isPasswordVisible = false;
  bool isRememberMe = false;

  Widget buildLoginTextField(IconData icon, String hintText, bool isPassword,
      {bool isEmail = false}) {
    TextEditingController controller =
        isEmail ? _emailTextController : _passwordController;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
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

  void _validateFieldsAndNavigate() {
    String email = _emailTextController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage('Please fill in all fields.');
      return;
    }

    if (!RegExp(r'^[a-z0-9](\.?[a-z0-9]){5,}@gmail\.com$').hasMatch(email)) {
      _showErrorMessage('Please enter a valid email address.');
      return;
    }

    if (password.length < 8) {
      _showErrorMessage('Password is Incorrect.');
      return;
    }

    _login();
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


  void _login() async {
    setState(() {
      isSigning = true;
    });

    String email = _emailTextController.text;
    String password = _passwordController.text;
    print("the email is:${ email}");

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSigning = false;
    });

    if (user != null) {
      print("User is successfully LogIn");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Dashboard()), // Replace YourHomePage with your intended home page
      );
    } else {
      _showErrorMessage("Credential is not Valid");
    }
  }

  Container SignInSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildLoginTextField(Icons.email, 'Email', false, isEmail: true),
          buildLoginTextField(Icons.lock, 'Password', true),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text('Remember me',
                      style: TextStyle(fontSize: 12, color: Palette.textColor1))
                ],
              ),
              TextButton(
                onPressed: () {
                  buildBottomSheet(context);
                },
                child: Text('Forget Password?',
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
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
                        text: "Welcome to ",
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: const Color(0xFFF79817),
                        ),
                        children: [
                          TextSpan(
                            text: "Zenfilter ",
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
                      "Sign in to Continue",
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
              height: 323,
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
                              'LOGIN',
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
                  SignInSection(),
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
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: const Text("Don't have an Account? SIGNUP",
                      style: TextStyle(
                        color: Color.fromARGB(255, 10, 10, 10),
                        fontSize: 16,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // buildTextButton(Icons.facebook, "Facebook", Palette.facebookColor),
                      // buildTextButton('images/google.png', "Google", Color(0xFFDE4B39)),
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
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        // Redirect to the home screen after signing in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard()), // Replace with your DashboardPage
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing in with Google: $e'),
        ),
      );
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

// Widget buildTextButton(dynamic icon, String title, Color backgroundColor) {
//   return TextButton(
//     onPressed: () => main(),
//     style: TextButton.styleFrom(
//       side: BorderSide(width: 1, color: Colors.grey),
//       minimumSize: Size(145, 40),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       primary: Colors.white,
//       backgroundColor: backgroundColor,
//     ),
//     child: Row(
//       children: [
//         if (icon is IconData) // Check if the icon is an IconData
//           Icon(
//             icon,
//           ),
//         if (icon is String) // Check if the icon is a String (assumed to be an asset path)
//           Image.asset(
//             icon,
//             width:30, // Adjust width and height as needed
//             height: 25,
//             // Other properties as required for the image-based icon
//           ),
//         SizedBox(width: 5),
//         Text(
//           title,
//         ),
//       ],
//     ),
//   );
// }

  Future<dynamic> buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      builder: (context) => Container(
        color: Colors.black, // Set background color to black
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select!",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: const Color(0xFFF79817)), // Set text color to orange
            ),
            Text(
              "Select the option given below to reset your password.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: const Color(0xFFF79817)),
            ),
            const SizedBox(height: 30.0),
            ForgotPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: 'E-Mail',
              subtitle: 'Reset via Mail Verification.',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ForgetPasswordMailScreen()),
                );
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
