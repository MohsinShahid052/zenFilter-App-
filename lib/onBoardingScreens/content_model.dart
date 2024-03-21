import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnbordingContent {
  String animationAsset;
  String title;
  String description;

  OnbordingContent({
    required this.animationAsset,
    required this.title,
    required this.description,
  });
}

List<OnbordingContent> contents = [
  OnbordingContent(
    title: 'Welcome to zenFilter',
    animationAsset: 'assets/animationAsset/applock.json',
    description:
        "ZenFilter, a browser enhancement, blocks URLs and keywords, features app locker, provides usage statistics, and ensures safe browsing.",
  ),
  OnbordingContent(
      title: 'App Lock',
      animationAsset: 'assets/animationAsset/applock.json',
      description:
          "Secure your apps with a unique lock, ensuring privacy and safety for your personal information and usage."),
  OnbordingContent(
    title: 'Safe Browser',
    animationAsset: 'assets/animationAsset/WebsiteAccess.json',
    description:
        " Navigate the internet safely, blocking harmful content and URLs, ensuring a secure and family-friendly browsing experience.",
  ),
  OnbordingContent(
    title: 'App Statistics',
    animationAsset: 'assets/animationAsset/AppStats.json',
    description:
        "Monitor your app usage with detailed statistics, helping you understand your habits and manage your digital wellbeing.",
  ),
];

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contents.length,
      itemBuilder: (context, index) {
        String description = '';

        // Matching title to set description
        switch (contents[index].title) {
          case 'Welcome to zenFilter':
            description =
                "ZenFilter, a browser enhancement, blocks URLs and keywords, features app locker, provides usage statistics, and ensures safe browsing";
            break;
          case 'App Lock':
            description =
                "Secure your apps with a unique lock, ensuring privacy and safety for your personal information and usage.";
            break;
          case 'Safe Browser':
            description =
                " Navigate the internet safely, blocking harmful content and URLs, ensuring a secure and family-friendly browsing experience.";
            break;
          case 'App Statistics':
            description =
                " Monitor your app usage with detailed statistics, helping you understand your habits and manage your digital wellbeing.";
            break;
          default:
            description = ''; // Default description if no match found
        }

        return Column(
          children: [
            Lottie.asset(
              contents[index].animationAsset,
              width: 200,
              height: 200,
            ),
            Text(contents[index].title),
            Text(description),
          ],
        );
      },
    );
  }
}
