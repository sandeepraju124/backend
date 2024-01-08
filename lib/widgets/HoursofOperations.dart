// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class HoursOfOperations extends StatefulWidget {
  const HoursOfOperations({super.key});

  @override
  State<HoursOfOperations> createState() => _HoursOfOperationsState();
}

class _HoursOfOperationsState extends State<HoursOfOperations> {
  List<String> _days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  Map<String, Map<String, dynamic>> operatingHours = {
    "Monday": {
      "startTime": TimeOfDay(hour: 9, minute: 0),
      "endTime": TimeOfDay(hour: 17, minute: 0),
      "schedule": true
    },
    "Tuesday": {
      "startTime": TimeOfDay(hour: 9, minute: 0),
      "endTime": TimeOfDay(hour: 17, minute: 0),
      "schedule": true
    },
    "Wednesday": {
      "startTime": TimeOfDay(hour: 9, minute: 0),
      "endTime": TimeOfDay(hour: 17, minute: 0),
      "schedule": true
    },
    "Thursday": {
      "startTime": TimeOfDay(hour: 9, minute: 0),
      "endTime": TimeOfDay(hour: 17, minute: 0),
      "schedule": true
    },
    "Friday": {
      "startTime": TimeOfDay(hour: 9, minute: 0),
      "endTime": TimeOfDay(hour: 17, minute: 0),
      "schedule": true
    },
    "Saturday": {
      "startTime": TimeOfDay(hour: 9, minute: 0),
      "endTime": TimeOfDay(hour: 17, minute: 0),
      "schedule": false
    },
    "Sunday": {
      "startTime": TimeOfDay(hour: 9, minute: 0),
      "endTime": TimeOfDay(hour: 17, minute: 0),
      "schedule": false
    },
  };

  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 3);

  void timePicker(String day, String time) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        print(value);
        // TimeOfDay(16:52)
        // _timeOfDay = value!;
        operatingHours[day]![time] = value;
        print("operatingHours[day].endTime");
        print(operatingHours[day]?["endTime"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hours of Operations")),
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(_timeOfDay.format(context).toString()),
          Expanded(
            child: ListView.builder(
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final day = _days[index].toString();
                final timeRange = operatingHours[day];
                final bool schedule = operatingHours[day]!["schedule"];
                // final timeRange = operatingHours[day].endTime;
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 40,
                        child: Text(
                          day,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(
                        flex: 60,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                timePicker(day, "startTime");
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                // width: 60,
                                // height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    timeRange!["startTime"].format(context),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                timePicker(day, "endTime");
                              },

                              child: Container(
                                padding: EdgeInsets.all(5),
                                // width: 60,
                                // height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    timeRange["endTime"].format(context),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // width: 50, // Adjust the width as needed
                        height: 38,
                        child: LiteRollingSwitch(
                          value: schedule,
                          width: 95,
                          textOn: 'Open',
                          textOff: 'Close',
                          colorOn: Colors.teal,
                          colorOff: Colors.grey,
                          iconOn: Icons.offline_bolt,
                          iconOff: Icons.power_settings_new,
                          // animationDuration: const Duration(milliseconds: 300),
                          onChanged: (bool state) {
                            print('turned ${(state) ? 'on' : 'off'}');
                          },
                          onDoubleTap: () {},
                          onSwipe: () {},
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
                );
                // Text("${timeRange.startTime.format(context)},${timeRange.endTime.format(context)}"),
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            // width: 100,
            height: 40,
            // color: Colors.red,
            decoration: BoxDecoration(
              color: Colors.teal,
              border: Border.all(
                color: Colors.grey, // You can customize the border color
                // width: 2.0, // You can customize the border width
              ),
            ),

            child: Text(
              'Save Edits',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
