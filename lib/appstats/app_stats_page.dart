import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zenFilter/appstats/custom_app_usage_info.dart'; 
// Make sure this class is defined

class AppStatsPage extends StatefulWidget {
  final List<String> selectedApps;
  AppStatsPage({required this.selectedApps});

  @override
  _AppStatsPageState createState() => _AppStatsPageState();
}

class _AppStatsPageState extends State<AppStatsPage> {
  List<CustomAppUsageInfo> appUsageData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAppUsageStats();
  }

  Future<void> getAppUsageStats() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 1));

    try {
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);
      setState(() {
        for (var app in infoList) {
          if (widget.selectedApps.contains(app.packageName)) {
            appUsageData.add(CustomAppUsageInfo(
              appName: app.packageName, // Ideally, map package names to app names if possible
              usage: app.usage.inMinutes.toDouble(),
            ));
          }
        }
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching app usage: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Stats'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SfCircularChart(
              title: ChartTitle(text: 'App Usage Distribution'),
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
                PieSeries<CustomAppUsageInfo, String>(
                  dataSource: appUsageData,
                  xValueMapper: (CustomAppUsageInfo data, _) => data.appName,
                  yValueMapper: (CustomAppUsageInfo data, _) => data.usage,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
    );
  }
}
