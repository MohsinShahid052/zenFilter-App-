import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Adjust the import path as necessary

class TeamHierarchyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF79817),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Created by leading experts in ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
            const Text(
              'FAST-NUCES',
              style: TextStyle(
                color: Color(0xFFF79817),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
            const SizedBox(height: 50),
            const TeamImage('images/supervisor.png', 'Mr. Ali Raza'),
            const SizedBox(height: 20),
            Container(
              width: 220,
              height: 2,
              color: const Color(0xFFF79817),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TeamImage('images/haseeb.png', 'Haseeb Mushtaq'),
                TeamImage('images/subhan.png', 'Subhan Arfat'),
                TeamImage('images/mohsin.png', 'Mohsin Shahid'),
              ],
            ),
            const SizedBox(height: 30),
            const ExpansionTileWidget(
              title: 'Haseeb Mushtaq',
              designation: 'Flutter UI & Backend Developer',
              githubUrl: 'https://github.com/AlamBinary01',
              linkedinProfile: 'https://www.linkedin.com/in/alambinary01/',
            ),
            const ExpansionTileWidget(
              title: 'Subhan Ateeq',
              designation: 'MERN Stack Developer',
              githubUrl: 'https://github.com/subhan-a19',
              linkedinProfile:
                  "https://www.linkedin.com/in/subhan-attique-48a7a8274/",
            ),
            const ExpansionTileWidget(
              title: 'Mohsin Shahid',
              designation: 'Mobile Developer',
              githubUrl: 'https://github.com/MohsinShahid052',
              linkedinProfile:
                  'https://www.linkedin.com/in/mohsin-shahid-7a321b264/',
            ),
          ],
        ),
      ),
    );
  }
}

class TeamImage extends StatelessWidget {
  final String imagePath;
  final String teamName;

  const TeamImage(this.imagePath, this.teamName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(imagePath, width: 100, height: 100),
        ),
        const SizedBox(height: 10),
        Text(
          teamName,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class ExpansionTileWidget extends StatelessWidget {
  final String title;
  final String designation;
  final String githubUrl;
  final String linkedinProfile;

  const ExpansionTileWidget({
    Key? key,
    required this.title,
    required this.designation,
    required this.githubUrl,
    required this.linkedinProfile,
  }) : super(key: key);

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        children: [
          ListTile(
            title: Text(
              '-> $designation',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _launchURL(githubUrl),
                  child: Image.asset(
                    "images/github.png",
                    width: 40,
                    height: 40,
                    color: const Color(0xFFF79817),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _launchURL(linkedinProfile),
                  child: Image.asset(
                    "images/linkedin.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
