import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "App_block.dart";
import 'package:zenFilter/Dashboard/dashboard.dart';
import "website_Block.dart";

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;
  bool valNotify4 = true;

  void onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  void onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  void onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  void onChangeFunction4(bool newValue4) {
    setState(() {
      valNotify4 = newValue4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color(0xFFF79817),
        title: Text('Preferences',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF79817),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 7, 7, 7),
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 10),
            buildNotificationOption(
                "Website Block", valNotify2, onChangeFunction2, Icons.block),
            buildNotificationOption("App Block", valNotify3, onChangeFunction3,
                Icons.app_blocking_outlined),
            buildNotificationOption("Default Preferences", valNotify4,
                onChangeFunction4, Icons.room_preferences_outlined),
            SizedBox(height: 10),
            buildAccountOption(context, "Custom Preferences"),
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangedMethod, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        children: [
          ListTile(
            tileColor: const Color(0xFFF79817),
            leading: Icon(icon, color: Colors.black),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      activeColor: const Color.fromARGB(255, 12, 12, 12),
                      trackColor: Colors.grey,
                      value: value,
                      onChanged: (bool newValue) {
                        onChangedMethod(newValue);
                      },
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Add your action when ListTile is tapped
            },
          ),
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlockWebsitePage()),
                      );
                    },
                    title: Row(
                      children: [
                        Image.asset(
                          'images/web-block.png',
                          width: 20,
                          height: 20,
                          color: const Color(0xFFF79817),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Website Block',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF79817),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BlockAppPage()),
                      );
                    },
                    title: Row(
                      children: [
                        Icon(Icons.app_blocking_outlined,
                            color: const Color(0xFFF79817)),
                        SizedBox(width: 10),
                        Text(
                          'App Block',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF79817),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                ListTile(
                  textColor: const Color(0xFFF79817),
                  title: Center(
                    child: Text('Close'),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orangeAccent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'images/custom_pre.png',
                width: 20,
                height: 20,
                color: const Color(0xFFF79817),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF79817),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: const Color(0xFFF79817)),
            ],
          ),
        ),
      ),
    );
  }
}
