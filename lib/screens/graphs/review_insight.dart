import 'dart:convert';

import 'package:backendapp/provider/insights_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;





 
// class ReviewInsightChart extends StatelessWidget {
//   // final Map<String, dynamic> reviewData;

//   // ReviewInsightChart({required this.reviewData});

//     Map<String, dynamic> reviewData= {
//         "monthly_data": {
//           "2023-12": {"monthly_rating": 0, "monthly_reviews_count": 55},
//           "2024-1": {"monthly_rating": 5.0, "monthly_reviews_count": 276},
//           "2024-2": {"monthly_rating": 2.3, "monthly_reviews_count": 600},
//           "2024-3": {"monthly_rating": 0, "monthly_reviews_count": 0},
//           "2024-4": {"monthly_rating": 2.0, "monthly_reviews_count": 1},
//           "2024-5": {"monthly_rating": 3.0, "monthly_reviews_count": 2}
//         },
//         "overall_rating": 2.9,
//         "reviews_count": 7
//       };

//   Future<void> fetchReviewsData() async {
//   var url = Uri.parse("https://supernova1137.azurewebsites.net/overall_rating/PIZFOO4357128905678/6");
//   print("Fetching data from: $url");
//   try {
//     var response = await http.get(url);
//     print("Response status: ${response.statusCode}");
//     if (response.statusCode == 200) {
//       var decodedJson = json.decode(response.body);
//       reviewData = json.decode(response.body);
//       print("Decoded JSON: $decodedJson");
//       var ratingData = RatingInsight.fromJson(decodedJson);

//       return ;
//     } else {
//       print("Error: ${response.reasonPhrase}");
//       throw Exception('Failed to load business profile');
//     }
//   } catch (error) {
//     print("Caught error: $error");
//     throw Exception('Failed to load business profile: $error');
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Review Insight'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Overall Rating: ${reviewData['overall_rating']}',
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'Total Reviews: ${reviewData['reviews_count']}',
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 20.0),
//             Expanded(
//               child: SfCartesianChart(
//                 primaryXAxis: CategoryAxis(),
//                 title: ChartTitle(text: 'Monthly Review Insights'),
//                 legend: Legend(isVisible: true),
//                 tooltipBehavior: TooltipBehavior(enable: true),
//                 series: <CartesianSeries>[
//                   LineSeries<MapEntry<String, Map<String, dynamic>>, String>(
//                     name: 'Rating',
//                     dataSource: reviewData['monthly_data'].entries.toList(),
//                     xValueMapper: (entry, _) => entry.key,
//                     yValueMapper: (entry, _) => entry.value['monthly_rating'],
//                     yAxisName: 'RatingAxis',
//                   ),
//                   ColumnSeries<MapEntry<String, Map<String, dynamic>>, String>(
//                     name: 'Reviews Count',
//                     dataSource: reviewData['monthly_data'].entries.toList(),
//                     xValueMapper: (entry, _) => entry.key,
//                     yValueMapper: (entry, _) => entry.value['monthly_reviews_count'],
//                   ),
//                 ],
//                 axes: <ChartAxis>[
//                   NumericAxis(
//                     name: 'RatingAxis',
//                     opposedPosition: true,
//                     interval: 1,
//                     minimum: 0,
//                     maximum: 5,
//                     title: AxisTitle(text: 'Rating'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewInsightChart extends StatefulWidget {
  @override
  _ReviewInsightChartState createState() => _ReviewInsightChartState();
}

class _ReviewInsightChartState extends State<ReviewInsightChart> {
  // late Map<String, dynamic> reviewData;
  // bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchReviewData();
  // }

  // Future<void> fetchReviewData() async {
  //   final response = await http.get(Uri.parse(
  //       'https://supernova1137.azurewebsites.net/overall_rating/PIZFOO4357128905678/6'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       reviewData = json.decode(response.body);
  //       isLoading = false;
  //     });
  //   } else {
  //     throw Exception('Failed to load review data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<InsightsProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.black38,
      appBar: AppBar(
        title: Text('Review Insight'),
      ),
      body: data.isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Overall Rating: ${data.reviewData!['overall_rating']}',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Total Reviews: ${data.reviewData!['reviews_count']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Monthly Review Insights'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        LineSeries<MapEntry<String, Map<String, dynamic>>, String>(
                          name: 'Rating',
                          dataSource: (data.reviewData!['monthly_data'] as Map<String, dynamic>).entries
                              .map<MapEntry<String, Map<String, dynamic>>>(
                                  (e) => MapEntry(e.key, Map<String, dynamic>.from(e.value)))
                              .toList(),
                          xValueMapper: (entry, _) => entry.key,
                          yValueMapper: (entry, _) => entry.value['monthly_rating'],
                          yAxisName: 'RatingAxis',
                        ),
                        ColumnSeries<MapEntry<String, Map<String, dynamic>>, String>(
                          name: 'Reviews Count',
                          dataSource: (data.reviewData!['monthly_data'] as Map<String, dynamic>).entries
                              .map<MapEntry<String, Map<String, dynamic>>>(
                                  (e) => MapEntry(e.key, Map<String, dynamic>.from(e.value)))
                              .toList(),
                          xValueMapper: (entry, _) => entry.key,
                          yValueMapper: (entry, _) => entry.value['monthly_reviews_count'],
                        ),
                      ],
                      axes: <ChartAxis>[
                        NumericAxis(
                          name: 'RatingAxis',
                          opposedPosition: true,
                          interval: 1,
                          minimum: 0,
                          maximum: 5,
                          title: AxisTitle(text: 'Rating'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
