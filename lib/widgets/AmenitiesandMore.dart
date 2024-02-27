// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AmenitiesandMoreSheet extends StatefulWidget {
  const AmenitiesandMoreSheet({
    super.key,
  });

  @override
  State<AmenitiesandMoreSheet> createState() => _AmenitiesandMoreSheetState();
}

class _AmenitiesandMoreSheetState extends State<AmenitiesandMoreSheet> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Amenities and more")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
          
          
              // padding: EdgeInsets.all(10),
              children: [
                // Text("Amenities and more",
                //     style: TextStyle(
                //       fontSize: 30,
                //     )),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Choose the amenities that you provide your customers, and we'll showcase this to your potential customers on your Yelp page and when you come up on search results."),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/business-report-svgrepo-com.svg",
                        height: 55),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Show your customers",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        // SizedBox(
                        //   height: 300,
                        // ),
          
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6)
                          ),
                          padding: EdgeInsets.all(10),
                          height: 90,
                          width: double.infinity,
                          // color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 40,
                                child: Container(
                                  child: Text(
                                    "Accessibility",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 60,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text("Accepts Debit Cards"),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Row(
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selected = 'Yes';
                                                    print(_selected);
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: _selected == 'Yes'
                                                      ? Colors.teal
                                                      : Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: _selected == "Yes"
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selected = 'No';
                                                    print(_selected);
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: _selected == 'No'
                                                      // ? Colors.red
                                                      // : Colors.grey[150],
                                                      ? Colors.teal
                                                      : Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                  ),
                                                ),
                                                child: Text('No',
                                                    style: TextStyle(
                                                        color: _selected == "No"
                                                            ? Colors.white
                                                            : Colors.black)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                        ),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    )),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
