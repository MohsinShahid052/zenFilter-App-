import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Usage Stats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppUsageScreen(),
    );
  }
}

class AppUsageScreen extends StatefulWidget {
  @override
  _AppUsageScreenState createState() => _AppUsageScreenState();
}

class _AppUsageScreenState extends State<AppUsageScreen> {
  Map<String, double> _usageData = {};
  bool _isLoading = true;
  Map<String, String> _appNames = {};

  @override
  void initState() {
    super.initState();
    getAppUsageStats();
  }

  Future<void> getAppUsageStats() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 7)); // Last 7 days

    List<AppUsageInfo> infoList = await AppUsage().getAppUsage(startDate, endDate);
    Map<String, double> tempUsageData = {};
    for (var info in infoList) {
      tempUsageData[info.packageName] = info.usage.inMinutes.toDouble();
    }

    // Now, get the app names
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true, includeAppIcons: false);
    Map<String, String> tempAppNames = {};
    for (Application app in apps) {
      if (tempUsageData.containsKey(app.packageName)) {
        tempAppNames[app.packageName] = app.appName;
      }
    }

    setState(() {
      _usageData = tempUsageData;
      _appNames = tempAppNames;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Stats'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SfCircularChart(
              title: ChartTitle(text: 'App Usage in Last 7 Days'),
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap
              ),
              series: <CircularSeries>[
                PieSeries<MapEntry<String, double>, String>(
                  dataSource: _usageData.entries.toList(),
                  xValueMapper: (MapEntry<String, double> data, _) => _appNames[data.key] ?? 'Unknown',
                  yValueMapper: (MapEntry<String, double> data, _) => data.value,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                    useSeriesColor: true,
                  ),
                  enableTooltip: true,
                  explode: true,
                  explodeIndex: 0,
                  explodeOffset: '10%',
                  startAngle: 90,
                  endAngle: 90,
                ),
              ],
            ),
    );
  }
}
