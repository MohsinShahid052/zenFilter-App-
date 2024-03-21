import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenFilter/login_signup/loginPage.dart';
import 'package:zenFilter/forgotPassword/forgotPassword.dart';
import 'package:zenFilter/forgotPassword/changePassword.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? _userImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserImage();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await _saveUserImagePath(pickedFile.path);
      setState(() {
        _userImagePath = pickedFile.path;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _saveUserImagePath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImagePath', path);
  }

  Future<void> _loadUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userImagePath = prefs.getString('userImagePath');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFFF79817),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 7, 7, 7)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: buildUserHeader(),
              ),
              buildSettingsItem(
                  context, "Change Password", Icons.password, _changePassword),
              buildSettingsItem(context, "Logout", Icons.logout, _logout),
              buildSettingsItem(context, "Delete Account", Icons.delete_forever,
                  _deleteAccount),
              buildSettingsItem(context, "Report a Bug/Feedback",
                  Icons.bug_report, _reportBug),
            ],
          ),
        ),
      );

  Widget buildUserHeader() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String email = currentUser?.email ?? "No email available";
    ImageProvider backgroundImage;

    if (_userImagePath != null) {
      backgroundImage = FileImage(File(_userImagePath!));
    } else {
      // Make sure to replace 'images/default_user.png' with an actual path in your assets
      backgroundImage = const AssetImage("images/woman.png");
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: backgroundImage,
        ),
        const SizedBox(height: 16),
        Text("ZenFilter User",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(email, style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget buildSettingsItem(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  void _changePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePassword()),
    );
    print("Change Password Tapped");
  }

  void _logout() async {
    // Placeholder function for logging out
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pop(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _deleteAccount() {
    print("Delete Account Tapped");
  }

  void _reportBug() {
    print("Report a Bug/Feedback Tapped");
  }
}
