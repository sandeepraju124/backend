// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:backendapp/screens/select_location.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:backendapp/widgets/linechart.dart';
import 'package:flutter/material.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          elevation: 1,
          title: Text("Insights"),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: (){
                // navigatorPush(context, BusinessLineChart());
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
                            return Container(
                                padding: EdgeInsets.all(15),
                                width: double.infinity,
                                child: BusinessLineChart());
                          },
                        );
                      },
                    );
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                  child: Container(
                    height: 140,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 65,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Jan reviews >",
                                      style: TextStyle(fontSize: 20)),
                                  Text("14K", style: TextStyle(fontSize: 25)),
                                  Text("80% incresed compared to last month",
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 35,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              // color: Colors.green,
                              child: Image.asset("assets/linegraph.png"),
                            )),
                      ],
                    ),
                  )),
            ),
            // SizedBox(height: 5,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                child: Container(
                  height: 140,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 65,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Jan reviews >",
                                    style: TextStyle(fontSize: 20)),
                                Text("234", style: TextStyle(fontSize: 25)),
                                Text("80% incresed compared to last month",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 35,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            // color: Colors.green,
                            child: Image.asset("assets/linegraph.png"),
                          )),
                    ],
                  ),
                ))
          ],
        ));
  }
}
