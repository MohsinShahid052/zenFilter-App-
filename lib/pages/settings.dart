import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import "./settingPages/reportBug.dart";
import './settingPages/accountPage.dart';
import '../Dashboard/dashboard.dart';
import '../pages/settingPages/reportBug.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? const Color(0xFFF79817) : Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDarkMode ? const Color(0xFFF79817) : Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            color: isDarkMode ? Colors.black : Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                buildUserHeader(),
                SettingsGroup(
                  title: "General",
                  children: <Widget>[
                    // buildDarkModeSwitch(),
                    const accountPage(),
                    buildLogout(context),
                    buildDeleteAccount(context),
                  ],
                ),
                const SizedBox(height: 32),
                SettingsGroup(
                  title: "Feedback",
                  children: <Widget>[
                    const SizedBox(height: 8),
                    buildReportBug(context),
                    buildSendFeedback(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  Widget buildDarkModeSwitch() {
    return ListTile(
      title: Text(
        "Dark Mode",
        style: TextStyle(
          color: isDarkMode ? const Color(0xFFF79817) : Colors.black,
        ),
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }

  Widget buildUserHeader() {
    final String username = "Haseeb Mushtaq";
    final String email = "f200316@cfd.nu.edu.pk";
    final String userImagePath = "images/woman.png";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(userImagePath),
        ),
        const SizedBox(height: 16),
        Text(
          username,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? const Color(0xFFF79817) : Colors.black,
          ),
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget buildLogout(BuildContext context) => SimpleSettingsTile(
        title: "Logout",
        subtitle: '',
        leading: const Icon(Icons.logout, color: Colors.black),
        onTap: () => showSnackBar(context, "Clicked Logout"),
      );

  Widget buildDeleteAccount(BuildContext context) => SimpleSettingsTile(
        title: "Delete Account",
        subtitle: '',
        leading: const Icon(Icons.delete, color: Colors.black),
        onTap: () => showSnackBar(context, "Clicked Delete Account"),
      );

  Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
      title: "Report a bug",
      subtitle: '',
      leading: const Icon(Icons.bug_report, color: Colors.black),
      onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ReportBug(),
            ),
          ));
  Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
        title: "Send Feedback",
        subtitle: '',
        leading: const Icon(Icons.thumb_up, color: Colors.black),
        onTap: () => showFeedbackDialog(context),
      );

  void showFeedbackDialog(BuildContext context) {
    double dialogHeight = MediaQuery.of(context).size.height * 0.5;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Feedback"),
          contentPadding:
              const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
          content: Container(
            height: dialogHeight,
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: const Text("Good"),
                  leading: const Icon(Icons.thumb_up, color: Colors.green),
                  onTap: () {
                    Navigator.of(context).pop();
                    showSnackBar(context, "Good feedback submitted");
                  },
                ),
                ListTile(
                  dense: true,
                  title: const Text("Bad"),
                  leading: const Icon(Icons.thumb_down, color: Colors.red),
                  onTap: () {
                    Navigator.of(context).pop();
                    showSnackBar(context, "Bad feedback submitted");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
