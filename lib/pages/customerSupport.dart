import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Dashboard/dashboard.dart'; // Replace with the actual path to your dashboard.dart file

class CustomerSupport extends StatelessWidget {
  const CustomerSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Zenfilter"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          },
        ),
      ),
      body: Tawk(
        directChatLink: dotenv.get('CHAT_LINK'),
        visitor: TawkVisitor(
          name: dotenv.get("NAME"),
          email: dotenv.get("EMAIL"),
        ),
      ),
    );
  }
}
