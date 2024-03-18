import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:app_usage/app_usage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

enum StatsTimePeriod { daily, weekly, monthly }

class InstalledAppsPage extends StatefulWidget {
  @override
  _InstalledAppsPageState createState() => _InstalledAppsPageState();
}

class _InstalledAppsPageState extends State<InstalledAppsPage> {
  List<Application> apps = [];
  List<Application> filteredApps = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getInstalledApps();
    searchController.addListener(filterApps);
  }

  Future<void> getInstalledApps() async {
    setState(() => isLoading = true);
    List<Application> installedApps = await DeviceApps.getInstalledApplications(
      includeSystemApps: false,
      includeAppIcons: true,
      onlyAppsWithLaunchIntent: true,
    );
    setState(() {
      apps = installedApps;
      filteredApps = List.from(apps);
      isLoading = false;
    });
  }

  void filterApps() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredApps = apps
          .where((app) => app.appName.toLowerCase().contains(query))
          .toList();
    });
  }

  void navigateToUsageGraph(String packageName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppUsageGraphPage(selectedPackage: packageName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primaryColor: Color(0xFFF79817),
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF79817),
          title: Text('Select App for Stats'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Search Apps',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredApps.length,
                      itemBuilder: (context, index) {
                        Application app = filteredApps[index];
                        return GestureDetector(
                          onTap: () => navigateToUsageGraph(app.packageName),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF79817),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.memory(
                                  app is ApplicationWithIcon
                                      ? app.icon!
                                      : Uint8List.fromList([]),
                                  width: 48,
                                  height: 48,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    app.appName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class AppUsageGraphPage extends StatefulWidget {
  final String selectedPackage;

  AppUsageGraphPage({required this.selectedPackage});

  @override
  _AppUsageGraphPageState createState() => _AppUsageGraphPageState();
}

class _AppUsageGraphPageState extends State<AppUsageGraphPage> {
  List<AppUsageInfo> usageInfo = [];
  bool isLoading = true;
  StatsTimePeriod selectedTimePeriod = StatsTimePeriod.daily;

  @override
  void initState() {
    super.initState();
    fetchUsageStats();
  }

  Future<void> fetchUsageStats() async {
    setState(() {
      isLoading = true;
    });

    DateTime endDate = DateTime.now();
    DateTime startDate = selectedTimePeriod == StatsTimePeriod.daily
        ? DateTime(endDate.year, endDate.month, endDate.day)
        : endDate.subtract(selectedTimePeriod == StatsTimePeriod.weekly
            ? Duration(days: 6)
            : Duration(days: 29));

    List<AppUsageInfo> infoList =
        await AppUsage().getAppUsage(startDate, endDate);
    setState(() {
      usageInfo = infoList
          .where((app) => app.packageName == widget.selectedPackage)
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFF79817),
        title: Text('App Usage Stats'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          DropdownButton<StatsTimePeriod>(
            value: selectedTimePeriod,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onChanged: (StatsTimePeriod? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTimePeriod = newValue;
                  fetchUsageStats();
                });
              }
            },
            items: StatsTimePeriod.values.map((StatsTimePeriod value) {
              return DropdownMenuItem<StatsTimePeriod>(
                value: value,
                child: Text(value == StatsTimePeriod.daily
                    ? 'Today'
                    : value == StatsTimePeriod.weekly
                        ? 'Last 7 Days'
                        : 'Last 30 Days'),
              );
            }).toList(),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                child: SfCartesianChart(
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    zoomMode: ZoomMode.x,
                    enableMouseWheelZooming: true,
                  ),
                  primaryXAxis: DateTimeAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    name: 'Date',
                    dateFormat: DateFormat('MMM dd'),
                    intervalType: DateTimeIntervalType.days,
                    interval: 1,
                  ),
                  primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    name: 'Usage time',
                    labelFormat: '{value} mins',
                  ),
                  title: ChartTitle(
                      text:
                          'App Usage - ${selectedTimePeriod == StatsTimePeriod.daily ? 'Today' : selectedTimePeriod == StatsTimePeriod.weekly ? 'Last 7 Days' : 'Last 30 Days'}',
                      textStyle: TextStyle(
                          color: Colors.white)), // Set text color to white
                  legend: const Legend(
                      isVisible: true, position: LegendPosition.bottom),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    ColumnSeries<AppUsageInfo, DateTime>(
                      dataSource: usageInfo,
                      xValueMapper: (AppUsageInfo usage, _) => usage.endDate,
                      yValueMapper: (AppUsageInfo usage, _) =>
                          newMethod(usage).usage.inMinutes,
                      name: 'Usage',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      width: 0.3, // Adjust bar width
                    )
                  ],
                ),
              ),
            ),
    );
  }

  AppUsageInfo newMethod(AppUsageInfo usage) => usage;
}
