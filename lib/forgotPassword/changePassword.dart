import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenFilter/login_signup/loginPage.dart';
import 'package:zenFilter/Dashboard/dashboard.dart'; // Importing the FormHeaderWidget class

class FormHeaderWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign textAlign;

  const FormHeaderWidget({
    required this.title,
    required this.subTitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign = TextAlign.left,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF79817),
          ),
          textAlign: textAlign,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFFF79817),
          ),
          textAlign: textAlign,
        ),
      ],
    );
  }
}

class ChangePassword extends StatelessWidget {
  TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: Text('Reset Password'),
          backgroundColor: const Color(0xFFF79817),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Dashboard'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Dashboard()));
                      },
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0 * 4),
                Image.asset('images/reset-password.png', height: 120),
                const SizedBox(height: 50.0),
                FormHeaderWidget(
                  title: 'Reset Password'.toUpperCase(),
                  subTitle: 'Enter E-mail to reset your password',
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailTextController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'E-Mail',
                          labelStyle: TextStyle(color: Colors.orange),
                          hintText: 'E-Mail',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.mail_outline_rounded,
                              color: Colors.orange),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !isValidEmail(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: _emailTextController.text)
                                .then((value) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            }).catchError((error) {
                              print(
                                  'Error sending password reset email: $error');
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[a-z0-9](\.?[a-z0-9]){5,}@gmail\.com$');
  return emailRegex.hasMatch(email);
}
