import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zenFilter/Dashboard/dashboard.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> blockedContentHistory = [
    {
      'name': 'Blocked Website 1',
      'timestamp': '2023-12-01 08:30:00',
      'reason': 'Inappropriate content',
    },
    {
      'name': 'Blocked App 2',
      'timestamp': '2023-12-01 10:45:00',
      'reason': 'Time limit exceeded',
    },
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color(0xFFF79817),
        title: Text('History', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF79817),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 7, 7, 7),
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  tileColor: const Color(0xFFF79817),
                  leading: Icon(Icons.auto_graph_outlined, color: Colors.black),
                  title: Text(
                    'Graphical Representation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(9, 9, 9, 1)),
                  ),
                ),
                SizedBox(height: 10),
                LineChart(),
                SizedBox(height: 30),
                ListTile(
                  tileColor: const Color(0xFFF79817),
                  leading: Icon(Icons.block_outlined, color: Colors.black),
                  title: Text(
                    'Blocked Content',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 8, 8, 8)),
                  ),
                ),
                Column(
                  children: blockedContentHistory
                      .map((item) => ListTile(
                            title: Text(
                              item['name'],
                              style: TextStyle(color: Color.fromARGB(255, 181, 45, 11)),
                            ),
                            subtitle: Text(
                              'Blocked at: ${item['timestamp']}',
                              style: TextStyle(color: const Color.fromARGB(255, 238, 235, 231)),
                            ),
                            trailing: Text(
                              'Reason: ${item['reason']}',
                              style: TextStyle(color: const Color.fromARGB(255, 238, 235, 231)),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData(x: 'Jan', yValue1: 45, yValue2: 1000),
      ChartData(x: 'Feb', yValue1: 100, yValue2: 3000),
      ChartData(x: 'March', yValue1: 25, yValue2: 1000),
      ChartData(x: 'April', yValue1: 100, yValue2: 7000),
      ChartData(x: 'May', yValue1: 85, yValue2: 5000),
      ChartData(x: 'June', yValue1: 140, yValue2: 7000),
    ];

    return Container(
      height: 250, // Reduced height for a smaller graph
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 2), // Orange border
        borderRadius: BorderRadius.circular(10),
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        axes: <ChartAxis>[
          NumericAxis(
            majorGridLines: MajorGridLines(width: 0), // Remove major grid lines
            name: 'yAxis1',
            interval: 1000,
            minimum: 0,
            maximum: 7000,
            opposedPosition: true,
            majorTickLines: MajorTickLines(size: 0), // Remove tick lines
          )
        ],
        // series: <ChartSeries<ChartData, String>>[
        //   ColumnSeries<ChartData, String>(
        //     animationDuration: 2000,
        //     dataSource: chartData,
        //     xValueMapper: (ChartData data, _) => data.x!,
        //     yValueMapper: (ChartData data, _) => data.yValue1!,
        //   ),
        //   LineSeries<ChartData, String>(
        //     animationDuration: 4500,
        //     animationDelay: 2000,
        //     dataSource: chartData,
        //     xValueMapper: (ChartData data, _) => data.x!,
        //     yValueMapper: (ChartData data, _) => data.yValue2!,
        //     yAxisName: 'yAxis1',
        //     markerSettings: MarkerSettings(isVisible: true),
        //   )
        // ],
      ),
    );
  }
}

class ChartData {
  ChartData({this.x, this.yValue1, this.yValue2});
  final String? x;
  final double? yValue1;
  final double? yValue2;
}
