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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Amenities and more")),
      body: Column(
    
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
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 90,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 40,
                              child: Container(
                                // color: Colors.red,
                                child: Text(
                                  "Accessibility",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                          Expanded(
                              flex: 60,
                              child: Container(
                                // color: Colors.blueAccent,
                                child: Row(children: [
                                  Expanded(
                                      child: Container(
                                    // color: Colors.lightGreenAccent,
                                    child: Text("Accepts Debit Cards"),
                                  )),
                                  Expanded(
                                      child: Container(
                                    // color: Colors.tealAccent,
                                    child: Row(children: [
                                      Radio(
                                        value: 'Yes',
                                        groupValue: _selected,
                                        onChanged: (value) {
                                          setState(() {
                                            _selected = value;
                                            print(value);
                                          });
                                        },
                                      ),
                                      Text('Yes'),
                                      Radio(
                                        value: 'No',
                                        groupValue: _selected,
                                        onChanged: (value) {
                                          setState(() {
                                            _selected = value;
                                            print(value);
                                          });
                                        },
                                      ),
                                      Text('No'),
                                    ]),
                                  ))
                                ]),
                              )),
                          // SizedBox(height: 300,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 90,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 40,
                              child: Container(
                                // color: Colors.red,
                                child: Text(
                                  "Accessibility",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                          Expanded(
                              flex: 60,
                              child: Container(
                                // color: Colors.blueAccent,
                                child: Row(children: [
                                  Expanded(
                                      child: Container(
                                    // color: Colors.lightGreenAccent,
                                    child: Text("Accepts Debit Cards"),
                                  )),
                                  Expanded(
                                      child: Container(
                                    // color: Colors.tealAccent,
                                    child: Row(children: [
                                      Radio(
                                        value: 'Yes',
                                        groupValue: _selected,
                                        onChanged: (value) {
                                          setState(() {
                                            _selected = value;
                                            print(value);
                                          });
                                        },
                                      ),
                                      Text('Yes'),
                                      Radio(
                                        value: 'No',
                                        groupValue: _selected,
                                        onChanged: (value) {
                                          setState(() {
                                            _selected = value;
                                            print(value);
                                          });
                                        },
                                      ),
                                      Text('No'),
                                    ]),
                                  ))
                                ]),
                              )),
                          // SizedBox(height: 300,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 90,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 40,
                              child: Container(
                                // color: Colors.red,
                                child: Text(
                                  "Accessibility",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                          Expanded(
                              flex: 60,
                              child: Container(
                                // color: Colors.blueAccent,
                                child: Row(children: [
                                  Expanded(
                                      child: Container(
                                    // color: Colors.lightGreenAccent,
                                    child: Text("Accepts Debit Cards"),
                                  )),
                                  Expanded(
                                      child: Container(
                                    // color: Colors.tealAccent,
                                    child: Row(children: [
                                      Radio(
                                        value: 'Yes',
                                        groupValue: _selected,
                                        onChanged: (value) {
                                          setState(() {
                                            _selected = value;
                                            print(value);
                                          });
                                        },
                                      ),
                                      Text('Yes'),
                                      Radio(
                                        value: 'No',
                                        groupValue: _selected,
                                        onChanged: (value) {
                                          setState(() {
                                            _selected = value;
                                            print(value);
                                          });
                                        },
                                      ),
                                      Text('No'),
                                    ]),
                                  ))
                                ]),
                              )),
                          // SizedBox(height: 300,)
                        ],
                      ),
                    ),
                    
                  ],
                )),
              ),
            )
          ]),
    );
  }
}
