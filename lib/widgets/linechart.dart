// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BusinessLineChart extends StatefulWidget {
  // String yaxis;

  // BusinessLineChart({super.key, required this.yaxis});

  @override
  _BusinessLineChartState createState() => _BusinessLineChartState();
}

class _BusinessLineChartState extends State<BusinessLineChart> {
  // List<Map<String, dynamic>> chartData = [
  //   {'month': 'Jan', 'Rating': 4.5, 'reviews': 20},
  //   {'month': 'Feb', 'Rating': 3.5, 'reviews': 142},
  //   {'month': 'Mar', 'Rating': 2.2, 'reviews': 42},
  //   {'month': 'Apr', 'Rating': 1.8, 'reviews': 642},
  //   {'month': 'May', 'Rating': 5.0, 'reviews': 342},
  //   {'month': 'Jun', 'Rating': 1.5, 'reviews': 742},
  //   // Add more data points for each month
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("${widget.yaxis} Over Months")),
      body: Column(children: [
        linegraph(yaxis: "reviews"),
        linegraph(yaxis: "Rating"),
      ])
      ,
    );
  }

  Container linegraph({required String yaxis}) {
    List<Map<String, dynamic>> chartData = [
    {'month': 'Jan', 'Rating': 4.5, 'reviews': 20},
    {'month': 'Feb', 'Rating': 3.5, 'reviews': 142},
    {'month': 'Mar', 'Rating': 2.2, 'reviews': 42},
    {'month': 'Apr', 'Rating': 1.8, 'reviews': 642},
    {'month': 'May', 'Rating': 5.0, 'reviews': 342},
    {'month': 'Jun', 'Rating': 1.5, 'reviews': 742},
    // Add more data points for each month
  ];
    return Container(
      // color: Colors.teal,
      padding: EdgeInsets.all(16.0),
      child: SfCartesianChart(
        // plotAreaBackgroundColor: Colors.teal[50],
        // primaryXAxis: CategoryAxis(),
        series: <LineSeries<Map<String, dynamic>, String>>[
          LineSeries<Map<String, dynamic>, String>(
            dataSource: chartData,
            xValueMapper: (data, _) => data['month'].toString(),
            yValueMapper: (data, _) => data[yaxis],
            name: '${yaxis} Over Months',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            markerSettings: MarkerSettings(color: Colors.blue, isVisible: true),
            enableTooltip: true,
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Month: \${point.x.toString()}, ${yaxis}: \${point.y.toString()}',
          textStyle: TextStyle(color: Colors.white),
        ),
        trackballBehavior: TrackballBehavior(
          enable: true,
          tooltipSettings: InteractiveTooltip(
            color: Colors.blue,
          ),
          lineType: TrackballLineType.vertical,
        ),
        title: ChartTitle(
          text: '${yaxis} Over Months',
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        legend: Legend(isVisible: true),
        plotAreaBorderColor: Colors.grey,
        plotAreaBorderWidth: 0.5,
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0.5, color: Colors.grey),
          labelStyle: TextStyle(color: Colors.black),
        ),
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0.5, color: Colors.grey),
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
