// import 'package:zenFilter/Dashboard/dashboard.dart';
// import 'package:zenFilter/internetConnect/adblocker.dart'; // Adjust based on your project structure
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zenFilter/internetConnect/adblocker.dart'; // Ensure this import path is correct.
// import 'package:flutter/material.dart';

// class BlockListManagementPage extends StatefulWidget {
//   @override
//   _BlockListManagementPageState createState() =>
//       _BlockListManagementPageState();
// }

// class _BlockListManagementPageState extends State<BlockListManagementPage> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> _dynamicBlockedList = [];
//   final Color orangeColor = Color(
//       0xFFF79817); // Define the orange color once and use it throughout your UI

//   @override
//   void initState() {
//     super.initState();
//     _loadDynamicBlockedList();
//   }

//   Future<void> _loadDynamicBlockedList() async {
//     final prefs = await SharedPreferences.getInstance();
//     _dynamicBlockedList = prefs.getStringList('blockedList') ?? [];
//     setState(() {});
//   }

//    bool _isValidUrl(String url) {
//     final urlRegExp = RegExp(
//         r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)\.[a-z]{2,5}(:[0-9]{1,5})?(\/.)?$');
//     return urlRegExp.hasMatch(url);
//   }

//   void _addUrlToList() async {
//     final String url = _controller.text.trim();
//     if (url.isNotEmpty && _isValidUrl(url)) {
//       final prefs = await SharedPreferences.getInstance();
//       List<String> blockedList = prefs.getStringList('blockedList') ?? [];
//       if (!blockedList.contains(url)) {
//         blockedList.add(url);
//         await prefs.setStringList('blockedList', blockedList);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('URL added to block list',
//                 style: TextStyle(color: orangeColor))));
//         _controller.clear();
//         _loadDynamicBlockedList();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('URL already in the block list',
//                 style: TextStyle(color: orangeColor))));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Please enter a valid URL.',
//               style: TextStyle(color: orangeColor))));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<String> wordsOnlyList = _dynamicBlockedList.where((item) => item.startsWith('http')).toList();
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: const Color(0xFFF79817),
//         title: Text(
//           'Block Websites',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFFF79817),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Dashboard()),
//             );
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         titleSpacing: 0,
//       ),
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _controller,
//               style: TextStyle(color: orangeColor), // Set the input text color
//               decoration: InputDecoration(
//                 labelText: 'Enter URL to block',
//                 labelStyle:
//                     TextStyle(color: orangeColor), // Set the label text color
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white, width: 2.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: orangeColor, width: 2.0),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.add, color: orangeColor),
//                   onPressed: _addUrlToList,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFF79817),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           SiteBlockerWebView()), // Adjust based on your actual navigation target
//                 );
//               },
//               child: Text('Go to Google',style: TextStyle(color: Colors.black)),
//               ),
//             SizedBox(height: 20),
//             ...wordsOnlyList
//               .map((item) => ListTile(
//                     title: Text(
//                       item,
//                       style: TextStyle(color: orangeColor),
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete, color: orangeColor),
//                       onPressed: () async {
//                         final prefs = await SharedPreferences.getInstance();
//                         _dynamicBlockedList.remove(item);
//                         await prefs.setStringList('blockedList', _dynamicBlockedList);
//                         setState(() {});
//                       },
//                     ),
//                   ))
//               .toList(),
//         ],
//       ),
//     ),
//   );
// }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenFilter/Dashboard/dashboard.dart';
import 'package:zenFilter/bridge.dart';

class BlockedWordsCount {
  static int count = 0;
}

class BlockListManagementPage extends StatefulWidget {
  @override
  _BlockListManagementPageState createState() =>
      _BlockListManagementPageState();
}

class _BlockListManagementPageState extends State<BlockListManagementPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _dynamicBlockedList = [];
  final Color orangeColor = Color(0xFFF79817);

  @override
  void initState() {
    super.initState();
    _loadDynamicBlockedList();
    BlockedWordsCount.count = 0;
  }

  Future<void> _loadDynamicBlockedList() async {
    final prefs = await SharedPreferences.getInstance();
    _dynamicBlockedList = prefs.getStringList('blockedList') ?? [];
    setState(() {});
    _updateBlockedWordsCount();
  }

  bool _isValidUrl(String url) {
    final urlRegExp = RegExp(
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)\.[a-z]{2,5}(:[0-9]{1,5})?(\/.)?$');
    return urlRegExp.hasMatch(url);
  }

  bool _isValidPK(String url) {
    final urlRegExp = RegExp(
        r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-zA-Z0-9-]{2,}\.([a-zA-Z]{2,11})(\.[a-zA-Z]{2,11})?(\.[a-zA-Z]{2,11})?([-a-zA-Z0-9@:%_\+.~#?&//=]*)$');
    return urlRegExp.hasMatch(url);
  }

  void _addUrlToList() async {
    final String url = _controller.text.trim();
    if (url.isNotEmpty && _isValidUrl(url) || _isValidPK(url)) {
      final prefs = await SharedPreferences.getInstance();
      List<String> blockedList = prefs.getStringList('blockedList') ?? [];
      if (!blockedList.contains(url)) {
        blockedList.add(url);
        await prefs.setStringList('blockedList', blockedList);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('URL added to block list',
                style: TextStyle(color: orangeColor))));
        _controller.clear();
        _loadDynamicBlockedList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('URL already in the block list',
                style: TextStyle(color: orangeColor))));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter a valid URL.',
              style: TextStyle(color: orangeColor))));
    }
  }

  void _deleteWord(String word) async {
    final prefs = await SharedPreferences.getInstance();
    _dynamicBlockedList.remove(word);
    await prefs.setStringList('blockedList', _dynamicBlockedList);
    setState(() {
      _updateBlockedWordsCount();
    });
  }

  void _updateBlockedWordsCount() {
    BlockedWordsCount.count =
        _dynamicBlockedList.where((item) => item.startsWith('http')).length;
  }

  @override
  Widget build(BuildContext context) {
    List<String> wordsOnlyList =
        _dynamicBlockedList.where((item) => item.startsWith('http')).toList();
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color(0xFFF79817),
        title: Text(
          'Block Web/URLs',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              style: TextStyle(color: orangeColor), // Set the input text color
              decoration: InputDecoration(
                labelText: 'Enter URL to block',
                labelStyle:
                    TextStyle(color: orangeColor), // Set the label text color
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF79817), width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: Color(0xFFF79817)),
                  onPressed: _addUrlToList,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF79817),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BridgeOfApp()), // Adjust based on your actual navigation target
                );
              },
              child:
                  Text('Go to Google', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            Text(
              'Total Blocked URLs: ${BlockedWordsCount.count}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            ...wordsOnlyList
                .map((item) => ListTile(
                      title: Text(
                        item,
                        style: TextStyle(color: orangeColor),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: orangeColor),
                        onPressed: () async {
                          _deleteWord(item);
                        },
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
