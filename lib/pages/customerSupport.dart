import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class CustomerSupport extends StatelessWidget {
  const CustomerSupport({Key? key})
      : super(key: key); // Consistent naming convention
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat', // Apply Montserrat as the default font
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF79817),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Customer Support',
              style: TextStyle(color: Colors.black)),
        ),
        body: Center(
          child: ContactUs(
            cardColor: const Color.fromARGB(255, 255, 255, 255),
            textColor: const Color.fromARGB(255, 0, 0, 0),
            logo: const AssetImage('images/logo.jpg'),
            email: 'zenfilter.software@gmail.com',
            companyName: 'ZenFilter',
            companyColor: const Color(0xFFF79817),
            dividerThickness: 2,
            phoneNumber: '+923328347560',
            tagLine: 'Flutter Developer',
            taglineColor: const Color(0xFFF79817),
            instagram: '27.http',
          ),
        ),
      ),
    );
  }
}
