import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';

class accountPage extends StatelessWidget {
  static const keyLanguage = "key-location";
  static const keyLocation = "key-language";
  static const keyPassword = 'key-password';

  const accountPage({Key? key});

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: "Account Settings",
        subtitle: 'Privacy, Security, Language',
        leading: const Icon(
          Icons.person,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        child: SettingsScreen(
          title: "Account Setting",
          children: <Widget>[
            buildLanguage(context),
            buildLocation(context),
            //buildPassword(context),
            buildPrivacy(context),
            buildSecurity(context),
            buildAccountInfo(context),
          ],
        ),
      );

  Widget buildLanguage(BuildContext context) => DropDownSettingsTile(
        settingKey: keyLanguage,
        title: 'Language',
        selected: 1,
        values: const <int, String>{1: 'English', 2: 'Urdu'},
        onChange: (language) {/*NOOP */},
      );

  Widget buildLocation(BuildContext context) => TextInputSettingsTile(
        settingKey: keyLocation,
        title: 'Location',
        initialValue: 'Pakistan',
        onChange: (location) {/*NOOP */},
      );
  Widget buildPassword(BuildContext context) => TextInputSettingsTile(
        title: "password",
        settingKey: keyPassword,
        obscureText: true,
        validator: (password) => password != null && password.length >= 8
            ? null
            : "Enter 6 Characters",
      );
  Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
        title: "Privacy",
        subtitle: '',
        leading: const Icon(
          Icons.lock,
          color: Colors.blue,
        ),
        onTap: () => showSnackBar(context, "Click Privacy"),
      );

  Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
        title: "Security",
        subtitle: '',
        leading: const Icon(
          Icons.security,
          color: Colors.blue,
        ),
        onTap: () => showSnackBar(context, "Click Security"),
      );

  Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
        title: "Account Info",
        subtitle: '',
        leading: const Icon(
          Icons.text_snippet,
          color: Colors.blue,
        ),
        onTap: () => showSnackBar(context, "Click Account Info"),
      );

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
