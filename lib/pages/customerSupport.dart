// import 'package:flutter/material.dart';
// //import 'package:flutter_tawk/flutter_tawk.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import '../Dashboard/dashboard.dart'; // Replace with the actual path to your dashboard.dart file

// class CustomerSupport extends StatelessWidget {
//   const CustomerSupport({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           "Zenfilter Customer Support",
//           style: TextStyle(color: Colors.orange),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Dashboard(),
//               ),
//             );
//           },
//           color: Colors.orange, // Set the arrow color to orange
//         ),
//         backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//         iconTheme: const IconThemeData(
//             color: Colors.orange), // Set the icon theme color
//       ),
//       body: Tawk(
//         directChatLink: dotenv.get('CHAT_LINK'),
//         visitor: TawkVisitor(
//           name: dotenv.get("NAME"),
//           email: dotenv.get("EMAIL"),
//         ),
//       ),
//     );
//   }
// }
