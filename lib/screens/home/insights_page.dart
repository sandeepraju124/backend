// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:backendapp/register/select_location.dart';
import 'package:backendapp/screens/graphs/review_insight.dart';
import 'package:backendapp/screens/graphs/profile_visit.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:backendapp/widgets/linechart.dart';
import 'package:flutter/material.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  final List<String> imagePaths = [
    'assets/linechart.png',
    'assets/17906.jpg',
    // 'assets/pie.jpg',
  ];

  // Define a mapping between image paths and screen route
  final Map<String, Widget> screenRoutes = {
    'assets/linechart.png': ReviewInsightChart(),
    'assets/17906.jpg': MonthlyViewsChart(),
    // 'assets/17906.jpg': MonthlyViewsChart()
  };

  List<String> insightNames = ["Review insights", "Profile visits"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 7,
          backgroundColor: tgPrimaryColor,
          title: Text(
            "Insights",
            style: TextStyle(fontSize: 17.4, fontWeight: FontWeight.w500),
          ),
        ),
        body: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            // childAspectRatio: 0.75, // Adjust aspect ratio as needed
            childAspectRatio: 3 / 4, // Adjust aspect ratio as needed
          ),
          itemCount: imagePaths.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print(imagePaths[index].characters);
                // Navigate to fullscreen chart page
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => FullScreenChart(
                //       imagePath: imagePaths[index],
                //     ),
                //   ),
                // );

                showModalBottomSheet(
                  isScrollControlled: true,
                  enableDrag: true,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      expand: false,
                      initialChildSize:
                          1.0, // Set to 1.0 for full screen height
                      minChildSize: 0.1, // Minimum height to stop at
                      maxChildSize:
                          1.0, // Maximum height to stop at (same as initialChildSize)
                      builder: (context, scrollController) {
                        return SafeArea(
                          child: Container(
                              // padding: EdgeInsets.all(15),

                              width: double.infinity,
                              child: screenRoutes[imagePaths[index]]!
                              // BusinessLineChart()
                              // ReviewInsightChart()
                              ),
                        );
                      },
                    );
                  },
                );
              },
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  title: Text(
                    insightNames[index],
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        )

        // Column(
        //   children: [
        //     GestureDetector(
        //       onTap: (){
        //         // navigatorPush(context, BusinessLineChart());
        //         showModalBottomSheet(
        //               isScrollControlled: true,
        //               enableDrag: true,
        //               context: context,
        //               builder: (context) {
        //                 return DraggableScrollableSheet(
        //                   expand: false,
        //                   initialChildSize:
        //                       1.0, // Set to 1.0 for full screen height
        //                   minChildSize: 0.1, // Minimum height to stop at
        //                   maxChildSize:
        //                       1.0, // Maximum height to stop at (same as initialChildSize)
        //                   builder: (context, scrollController) {
        //                     return Container(
        //                         padding: EdgeInsets.all(15),
        //                         width: double.infinity,
        //                         child:
        //                         // BusinessLineChart()
        //                         ReviewInsightChart()
        //                         );
        //                   },
        //                 );
        //               },
        //             );
        //       },
        //       child: Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        //           child: Container(
        //             height: 140,
        //             // color: Colors.white,
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //             ),
        //             child: Row(
        //               children: [
        //                 Expanded(
        //                     flex: 65,
        //                     child: Container(
        //                       padding: EdgeInsets.all(15),
        //                       // color: Colors.red,
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                         children: [
        //                           Text("Jan reviews >",
        //                               style: TextStyle(fontSize: 20)),
        //                           Text("14K", style: TextStyle(fontSize: 25)),
        //                           Text("80% incresed compared to last month",
        //                               style: TextStyle(color: Colors.grey)),
        //                         ],
        //                       ),
        //                     )),
        //                 Expanded(
        //                     flex: 35,
        //                     child: Container(
        //                       padding: EdgeInsets.all(10),
        //                       // color: Colors.green,
        //                       child: Image.asset("assets/linegraph.png"),
        //                     )),
        //               ],
        //             ),
        //           )),
        //     ),
        //     // SizedBox(height: 5,),
        //     Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        //         child: Container(
        //           height: 140,
        //           // color: Colors.white,
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //           ),
        //           child: Row(
        //             children: [
        //               Expanded(
        //                   flex: 65,
        //                   child: Container(
        //                     padding: EdgeInsets.all(15),
        //                     // color: Colors.red,
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                       children: [
        //                         Text("Jan reviews >",
        //                             style: TextStyle(fontSize: 20)),
        //                         Text("234", style: TextStyle(fontSize: 25)),
        //                         Text("80% incresed compared to last month",
        //                             style: TextStyle(color: Colors.grey)),
        //                       ],
        //                     ),
        //                   )),
        //               Expanded(
        //                   flex: 35,
        //                   child: Container(
        //                     padding: EdgeInsets.all(10),
        //                     // color: Colors.green,
        //                     child: Image.asset("assets/linegraph.png"),
        //                   )),
        //             ],
        //           ),
        //         ))
        //   ],
        // )
        );
  }
}
