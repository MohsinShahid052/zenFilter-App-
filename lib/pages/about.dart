import 'package:flutter/material.dart';


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
            const SizedBox(height: 30), // Increased space
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
            const SizedBox(height: 50), // Increased space
            const TeamImage('images/supervisor.png', 'Mr. Ali Raza'),
            const SizedBox(height: 20), // Increased space
            Container(
              width: 220,
              height: 2,
              color: const Color(0xFFF79817),
            ),
            const SizedBox(height: 20), // Increased space
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimatedTeamMember('images/haseeb.png', 'Haseeb Mushtaq'),
                _buildAnimatedTeamMember('images/subhan.png', 'Subhan Arfat'),
                _buildAnimatedTeamMember('images/mohsin.png', 'Mohsin Shahid'),
              ],
            ),
            const SizedBox(height: 30), // Adjust as needed
            const ExpansionTileWidget(
              title: 'Haseeb Mushtaq',
              designation: 'Flutter UI & Backend Developer',
              githubUrl: 'https://github.com/',
              linkedinProfile: 'YourLinkedInProfile',
            ),
            ExpansionTileWidget(
              title: 'Subhan Ateeq',
              designation: 'MERN Stack Developer',
              githubUrl: 'https://github.com/',
              linkedinProfile: 'YourLinkedInProfile',
            ),
            ExpansionTileWidget(
              title: 'Mohsin Shahid',
              designation: 'Mobile Developer',
              githubUrl: 'https://github.com/e',
              linkedinProfile: 'YourLinkedInProfile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTeamMember(String imagePath, String name) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: TeamWithBlueLine(imagePath, name),
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
        const SizedBox(height: 10), // Adjust as needed
        Text(
          teamName,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class TeamWithBlueLine extends StatelessWidget {
  final String imagePath;
  final String teamName;

  const TeamWithBlueLine(this.imagePath, this.teamName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(imagePath, width: 100, height: 100),
        ),
        const SizedBox(height: 10), // Adjust as needed
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
                Image.asset(
                  "images/github.png",
                  width: 40,
                  height: 40,
                  color: const Color(0xFFF79817),
                ),
                const SizedBox(width: 10), // Adjust as needed
                Image.asset(
                  "images/linkedin.png",
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
