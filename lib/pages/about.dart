import 'package:flutter/material.dart';
<<<<<<< HEAD
//import 'package:url_launcher/url_launcher.dart';
import '../Dashboard/dashboard.dart';

class TeamHierarchyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Created by leading experts in ', // Replace with your bold text
              style: TextStyle(
                color: Colors.white,
                fontSize: 20, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu",
              ),
            ),
            const Text(
              'FAST-NUCES', // Replace with your bold text
              style: TextStyle(
                color: Color(0xFFF79817), // #F79817 color
                fontSize: 20, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu",
              ),
            ),
            const SizedBox(height: 40),
            const TeamImage('images/woman.png', 'Mr. Ali Raza'),
            const SizedBox(height: 10),
            Container(
              width: 220,
              height: 2,
              color: Color(0xFFF79817), // #F79817 color
            ),
            const SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: const TeamWithBlueLine(
                        'images/woman.png',
                        'Haseeb Mushtaq',
                      ),
                    );
                  },
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: const TeamWithBlueLine(
                        'images/woman.png',
                        'Subhan Ateeq',
                      ),
                    );
                  },
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: const TeamWithBlueLine(
                        'images/woman.png',
                        'Mohsin Shahid',
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            // ExpansionTiles for developers
            buildExpansionTile(
                'Haseeb Mushtaq',
                'Flutter UI & Backend Developer',
                'https://github.com/',
                'YourLinkedInProfile'),
            buildExpansionTile('Subhan Ateeq', 'MERN Stack Developer',
                'https://github.com/', 'YourLinkedInProfile'),
            buildExpansionTile('Mohsin Shahid', 'Mobile Developer',
                'https://github.com/e', 'YourLinkedInProfile'),
=======

class aboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter About Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsPage()),
            );
          },
          child: Text('About Us'),
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Our App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to our amazing app. This is where you can provide information about your app, its purpose, features, and more.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Our Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('John Doe'),
              subtitle: Text('Developer'),
            ),
            ListTile(
              title: Text('Jane Smith'),
              subtitle: Text('Designer'),
            ),
>>>>>>> 4e843dd087a2fa91dc5ea81c32aced89384b2164
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD

  ExpansionTile buildExpansionTile(String title, String designation,
      String githubUrl, String linkedinProfile) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFFF79817)), // #F79817 color
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
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 2,
                      height: 20,
                      color: const Color(0xFFF79817), // #F79817 color
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "images/github.png",
                  width: 40,
                  height: 40,
                  color: const Color(0xFFF79817), // #F79817 color
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "images/linkedin.png",
                  width: 40,
                  height: 40,
                ),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 2,
                      height: 20,
                      color: const Color(0xFFF79817), // #F79817 color
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
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
        const SizedBox(height: 8),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 2,
                  height: 20,
                  color: const Color(0xFFF79817), // #F79817 color
                ),
              );
            },
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: ClipOval(
                  child: Image.asset(imagePath, width: 100, height: 100),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Text(
                  teamName,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
=======
>>>>>>> 4e843dd087a2fa91dc5ea81c32aced89384b2164
}
