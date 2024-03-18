import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import "package:zenFilter/appstats/installed_apps_page.dart";
import "package:zenFilter/appstats/graph.dart";

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Map<String, List<String>> appCategories = {
    'Social': [
      'com.facebook.katana',
      'com.google.android.youtube',
      'com.whatsapp',
      'com.instagram.android',
      'com.tencent.mm',
      'com.zhiliaoapp.musically',
      'com.facebook.orca',
      'org.telegram.messenger',
      'com.snapchat.android',
      'com.ss.android.ugc.aweme',
      'com.smile.gifmaker',
      'com.twitter.android',
      'com.sina.weibo',
      'com.tencent.mobileqq',
      'com.pinterest',
    ],
    'Entertainment': [
      'com.spotify.music',
      'com.netflix.mediaclient',
      'com.amazon.avod.thirdpartyclient',
      'com.google.android.youtube',
      'com.spotify.music',
      'com.disney.disneyplus',
      'com.microsoft.xboxone.smartglass',
      'tv.twitch.android.app',
      'com.hulu.plus'
    ],
    'Productivity': [
      'com.google.android.apps.docs',
      'com.microsoft.office.word',
      'com.Slack', // Assuming placeholder package name for Slack
      'com.dropbox.android', // Dropbox
      'com.google.android.gm', // Gmail
      'com.google.android.apps.docs', // Google Docs
      'com.intsig.camscanner', // CamScanner
      'com.mobilereference.PDFExpert', // PDF Expert (Note: Placeholder, actual package name might differ)
      'com.adobe.reader', // Adobe Acrobat Reader
      'com.toggl.timer', // Toggl
      'com.anydo', // Any.do
      'com.microsoft.todos', // Microsoft To Do (assuming for "my task")
      'com.llamalab.automate', // Automate
      'com.catchingnow.tinyclipboardmanager'
    ],
  };

  Map<String, double> categoryUsage = {
    'Social': 0,
    'Entertainment': 0,
    'Productivity': 0
  };
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppUsageStats();
  }

  Future<void> fetchAppUsageStats() async {
    setState(() => isLoading = true);

    DateTime endDate = DateTime.now();
    DateTime startDate =
        endDate.subtract(Duration(days: 7)); // Fetch data for the last week

    List<AppUsageInfo> infoList =
        await AppUsage().getAppUsage(startDate, endDate);

    Map<String, double> newCategoryUsage = {
      'Social': 0,
      'Entertainment': 0,
      'Productivity': 0
    };

    // Calculate usage for each category
    for (var info in infoList) {
      for (var category in appCategories.keys) {
        if (appCategories[category]!.contains(info.packageName)) {
          newCategoryUsage[category] =
              (newCategoryUsage[category] ?? 0) + info.usage.inMinutes;
        }
      }
    }

    setState(() {
      categoryUsage = newCategoryUsage;
      isLoading = false;
    });
  }

  Widget buildStatsCard(
      String title, String value, Color color, IconData iconData) {
    return Card(
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: const Color.fromARGB(255, 0, 0, 0),
              size: 36, // Adjust the size as needed
            ),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0), fontSize: 18)),
            SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apps Statistics'),
        backgroundColor: const Color(0xFFF79817), // Set app bar color to blue
        iconTheme:
            IconThemeData(color: Colors.black), // Set icon color to black
      ),
      backgroundColor: const Color(0xFFF79817),
      body: Center(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Category Stats',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: categoryUsage.entries.map((entry) {
                  IconData? iconData;
                  if (entry.key == 'Social') {
                    iconData = Icons.group;
                  } else if (entry.key == 'Productivity') {
                    iconData = Icons.work;
                  } else if (entry.key == 'Entertainment') {
                    iconData = Icons.movie;
                  }
                  return buildStatsCard(
                    entry.key,
                    '${entry.value.toStringAsFixed(0)} mins',
                    Color(0xFFF79817)!,
                    iconData ?? Icons.error,
                  );
                }).toList(),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InstalledAppsPage(), // Replace with your installed_app_stats.dart page
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF79817),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insert_chart,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                      SizedBox(width: 10),
                      Text('Individual Apps',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyApp(), // Replace with your installed_app_stats.dart page
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF79817),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pie_chart,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      SizedBox(width: 10),
                      Text('Over All Stats',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
