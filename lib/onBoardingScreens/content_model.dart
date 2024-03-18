import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnbordingContent {
  String animationAsset;
  String title;
  String description;

  UnbordingContent({
    required this.animationAsset,
    required this.title,
    required this.description,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Welcome to zenFilter',
    animationAsset: 'assets/animationAsset/applock.json',
    description:
        "zenFilter is our app dedicated to the same purpose, effectively detecting and blocking explicit and violent content. It goes beyond, notifying guardians promptly to ensure a secure digital experience for users.",
  ),
  UnbordingContent(
    title: 'App Lock',
    animationAsset: 'assets/animationAsset/applock.json',
    description:
        "Ensure a safe digital environment for your family as our app diligently blocks explicit content, providing a secure online space where parents can trust that inappropriate material is kept at bay.",
  ),
  UnbordingContent(
    title: 'Safe Browser',
    animationAsset: 'assets/animationAsset/WebsiteAccess.json',
    description:
        "Create a applock-free digital space for your loved ones with our app, intelligently blocking any harmful content. Enjoy a worry-free online experience knowing that our advanced filters prioritize safety and well-being.",
  ),
  UnbordingContent(
    title: 'App Statistics',
    animationAsset: 'assets/animationAsset/AppStats.json',
    description:
        "Empower parents with peace of mind using our app's robust parental control features, allowing them to safeguard their children's online experiences with ease and confidence.",
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
                "zenFilter is our app dedicated to the same purpose, effectively detecting and blocking explicit and violent content. It goes beyond, notifying guardians promptly to ensure a secure digital experience for users.";
            break;
          case 'App Lock':
            description =
                "Ensure a safe digital environment for your family as our app diligently blocks explicit content, providing a secure online space where parents can trust that inappropriate material is kept at bay.";
            break;
          case 'Safe Browser':
            description =
                "Create a applock-free digital space for your loved ones with our app, intelligently blocking any harmful content. Enjoy a worry-free online experience knowing that our advanced filters prioritize safety and well-being.";
            break;
          case 'App Statistics':
            description =
                "Empower parents with peace of mind using our app's robust parental control features, allowing them to safeguard their children's online experiences with ease and confidence.";
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
