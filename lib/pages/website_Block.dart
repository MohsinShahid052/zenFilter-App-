import 'package:flutter/material.dart';
import 'package:zenFilter/Dashboard/dashboard.dart';

class BlockWebsitePage extends StatefulWidget {
  @override
  _BlockWebsitePageState createState() => _BlockWebsitePageState();
}

class _BlockWebsitePageState extends State<BlockWebsitePage> {
  TextEditingController _urlController = TextEditingController();
  List<String> blockedURLs = [];


  bool isURLValid(String url) {
    final urlRegExp = RegExp(
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
    return urlRegExp.hasMatch(url);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shadowColor: const Color(0xFFF79817),
          title: Text(
            'Block Websites',
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
              TextField(
                controller: _urlController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter URL to block',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFFF79817), width: 3.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add, color: const Color(0xFFF79817)),
                    hoverColor: Color.fromARGB(255, 223, 221, 219),
                    onPressed: () {
                      String enteredEmail = _urlController.text;
                      if (isURLValid(enteredEmail)) {
                        setState(() {
                          blockedURLs.add(enteredEmail);
                          _urlController.clear();
                        });
                      } else {
                        // Show an error message for invalid email format
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black, // Setting the background color
                              title: Text(
                                'Invalid URL Format',
                                style: TextStyle(color: const Color(0xFFF79817)), // Setting title text color
                              ),
                              content: Text(
                                'Please enter a valid URL address.',
                                style: TextStyle(color: const Color(0xFFF79817)), // Setting content text color
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: const Color(0xFFF79817)), // Setting button text color
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Blocked URLs:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFFF79817)),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: blockedURLs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        blockedURLs[index],
                        style: TextStyle(color: const Color(0xFFF79817)),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: const Color(0xFFF79817)),
                        onPressed: () {
                          setState(() {
                            blockedURLs.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


