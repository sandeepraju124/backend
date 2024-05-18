import "package:backendapp/provider/insights_provider.dart";
import "package:flutter/material.dart";
import "package:syncfusion_flutter_charts/charts.dart";
import 'package:provider/provider.dart';




class MonthlyViewsChart extends StatefulWidget {

  @override
  State<MonthlyViewsChart> createState() => _MonthlyViewsChartState();
}

class _MonthlyViewsChartState extends State<MonthlyViewsChart> {

  // final Map<String, dynamic> data = {
  //   "monthly_data": {
  //     "2024-01": {"monthly_views_count": 0},
  //     "2024-02": {"monthly_views_count": 0},
  //     "2024-03": {"monthly_views_count": 0},
  //     "2024-04": {"monthly_views_count": 1},
  //     "2024-05": {"monthly_views_count": 6}
  //   },
  //   "overall_views": 7
  // };

  //   final Map<String, dynamic> data = {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<InsightsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Visit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                    // 'Overall Rating: ${data.reviewData!['overall_rating']}',
                    'Total Impressions : ${data.profileVisitData!['overall_views']}',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
            Container(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries>[
                  BarSeries<MapEntry<String, dynamic>, String>(
                    dataSource: data.profileVisitData!['monthly_data'].entries.toList(),
                    xValueMapper: (entry, _) => entry.key,
                    yValueMapper: (entry, _) => entry.value['monthly_views_count'],
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries>[
                  LineSeries<MapEntry<String, dynamic>, String>(
                    dataSource: data.profileVisitData!['monthly_data'].entries.toList(),
                    xValueMapper: (entry, _) => entry.key,
                    yValueMapper: (entry, _) => entry.value['monthly_views_count'],
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}