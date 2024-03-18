import 'package:flutter/material.dart';
import "package:zenFilter/Dashboard/dashboard.dart";

class BlockAppPage extends StatefulWidget {
  @override
  _BlockAppPageState createState() => _BlockAppPageState();
}

class _BlockAppPageState extends State<BlockAppPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> blockedApps = [];
  List<String> allApps = [
    'Facebook',
    'Instagram',
    'WhatsApp',
    'Twitter',
    'Snapchat',
    'Youtube',
    'Tinder',
    'omegle TV',
    'BiGO Live',
    'TikTok',
    // Add more app names as needed
  ];

  String selectedApp = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shadowColor: const Color(0xFFF79817),
          title: Text(
            'Block Apps',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
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
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          titleSpacing: 0,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _openAppMenu,
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search App to block',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xFFF79817), width: 3.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: const Color(0xFFF79817)),
                    onPressed: _confirmBlock,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Blocked Apps:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF79817)),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: blockedApps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        blockedApps[index],
                        style: TextStyle(color: const Color(0xFFF79817)),
                      ),
                      trailing: IconButton(
                        icon:
                            Icon(Icons.delete, color: const Color(0xFFF79817)),
                        onPressed: () {
                          setState(() {
                            blockedApps.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _openAppMenu() {
    List<String> availableApps =
        allApps.where((app) => !blockedApps.contains(app)).toList();
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 100, 0, 0),
      items: availableApps.map((String app) {
        return PopupMenuItem<String>(
          value: app,
          child: Text(app),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _searchController.text = value;
          selectedApp = value;
        });
      }
    });
  }

  void _confirmBlock() {
    selectedApp = _searchController.text;
    if (selectedApp.isNotEmpty) {
      if (blockedApps.contains(selectedApp)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black, // Set background color
              title: Text(
                'Already Blocked',
                style: TextStyle(color: Colors.orange), // Set text color
              ),
              content: Text(
                '$selectedApp is already blocked.',
                style: TextStyle(color: Colors.orange), // Set text color
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black, // Set background color
              title: Text(
                'Confirm Block',
                style: TextStyle(color: Colors.orange), // Set text color
              ),
              content: Text(
                'Are you sure you want to block $selectedApp?',
                style: TextStyle(color: Colors.orange), // Set text color
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      blockedApps.add(selectedApp);
                    });
                    _searchController.clear();
                    selectedApp = '';
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
