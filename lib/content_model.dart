class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({
    this.image = '',
    this.title = '',
    this.discription = '',
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Welcome to zenFilter',
    image: 'images/hh.svg',
    discription:
        "zenFilter is our app dedicated to the same purpose, effectively detecting and blocking explicit and violent content. It goes beyond, notifying guardians promptly to ensure a secure digital experience for users. ",
  ),
  UnbordingContent(
    title: 'Explicit Content Detection',
    image: 'images/explicit.svg',
    discription:
        "Ensure a safe digital environment for your family as our app diligently blocks explicit content, providing a secure online space where parents can trust that inappropriate material is kept at bay. ",
  ),
  UnbordingContent(
    title: 'Voilent Content Detection',
    image: 'images/voilence.svg',
    discription:
        "Create a violence-free digital space for your loved ones with our app, intelligently blocking any harmful content. Enjoy a worry-free online experience knowing that our advanced filters prioritize safety and well-being ",
  ),
  UnbordingContent(
    title: 'Parental Control',
    image: 'images/parental.svg',
    discription:
        "Empower parents with peace of mind using our app's robust parental control features, allowing them to safeguard their children's online experiences with ease and confidence ",
  ),
];
