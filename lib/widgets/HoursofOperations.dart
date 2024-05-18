// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// import 'package:provider/provider.dart';

// class HoursOfOperations extends StatefulWidget {
//   const HoursOfOperations({super.key});

//   @override
//   State<HoursOfOperations> createState() => _HoursOfOperationsState();
// }

// class _HoursOfOperationsState extends State<HoursOfOperations> {
//   List<String> _days = [
//     "Monday",
//     "Tuesday",
//     "Wednesday",
//     "Thursday",
//     "Friday",
//     "Saturday",
//     "Sunday",
//   ];

//   // late Map<String, Map<String, dynamic>> operatingHours;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize operatingHours map with default values
//     var data = Provider.of<ServicesProvider>(context, listen: false);
//     print(data.BusinessData!.openingHours[0].day);
//     print('operating hours');
//     // operatingHours = {
//     //   "Monday": {
//     //     "startTime": data.BusinessData!.openingHours[0],
//     //     "endTime": data.openingHours[0].endTime,
//     //     "schedule": true
//     //   },
//     //   "Tuesday": {
//     //     "startTime": data.openingHours[1].startTime,
//     //     "endTime": data.openingHours[1].endTime,
//     //     "schedule": true
//     //   },
//     //   "Wednesday": {
//     //     "startTime": data.openingHours[2].startTime,
//     //     "endTime": data.openingHours[2].endTime,
//     //     "schedule": true
//     //   },
//     //   "Thursday": {
//     //     "startTime": data.openingHours[3].startTime,
//     //     "endTime": data.openingHours[3].endTime,
//     //     "schedule": true
//     //   },
//     //   "Friday": {
//     //     "startTime": data.openingHours[4].startTime,
//     //     "endTime": data.openingHours[4].endTime,
//     //     "schedule": true
//     //   },
//     //   "Saturday": {
//     //     "startTime": data.openingHours[5].startTime,
//     //     "endTime": data.openingHours[5].endTime,
//     //     "schedule": false
//     //   },
//     //   "Sunday": {
//     //     "startTime": data.openingHours[6].startTime,
//     //     "endTime": data.openingHours[6].endTime,
//     //     "schedule": false
//     //   },
//     // };
//   }

//   Map<String, Map<String, dynamic>> operatingHours = {
//     "Monday": {
//       "startTime": TimeOfDay(hour: 9, minute: 0),
//       "endTime": TimeOfDay(hour: 17, minute: 0),
//       "schedule": true
//     },
//     "Tuesday": {
//       "startTime": TimeOfDay(hour: 9, minute: 0),
//       "endTime": TimeOfDay(hour: 17, minute: 0),
//       "schedule": true
//     },
//     "Wednesday": {
//       "startTime": TimeOfDay(hour: 9, minute: 0),
//       "endTime": TimeOfDay(hour: 17, minute: 0),
//       "schedule": true
//     },
//     "Thursday": {
//       "startTime": TimeOfDay(hour: 9, minute: 0),
//       "endTime": TimeOfDay(hour: 17, minute: 0),
//       "schedule": true
//     },
//     "Friday": {
//       "startTime": TimeOfDay(hour: 9, minute: 0),
//       "endTime": TimeOfDay(hour: 17, minute: 0),
//       "schedule": true
//     },
//     "Saturday": {
//       "startTime": TimeOfDay(hour: 9, minute: 0),
//       "endTime": TimeOfDay(hour: 17, minute: 0),
//       "schedule": false
//     },
//     "Sunday": {
//       "startTime": TimeOfDay(hour: 9, minute: 0),
//       "endTime": TimeOfDay(hour: 17, minute: 0),
//       "schedule": false
//     },
//   };

//   TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 3);

//   void timePicker(String day, String time) {
//     showTimePicker(context: context, initialTime: TimeOfDay.now())
//         .then((value) {
//       setState(() {
//         print(value);
//         // TimeOfDay(16:52)
//         // _timeOfDay = value!;
//         operatingHours[day]![time] = value;
//         print("operatingHours[day].endTime");
//         print(operatingHours[day]?["endTime"]);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var data = Provider.of<ServicesProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text("Hours of Operations")),
//       backgroundColor: Colors.grey[100],
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 40,
//           ),
//           Text(_timeOfDay.format(context).toString()),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _days.length,
//               itemBuilder: (context, index) {
//                 final day = _days[index].toString();
//                 final timeRange = operatingHours[day];
//                 final bool schedule = operatingHours[day]!["schedule"];
//                 // final timeRange = operatingHours[day].endTime;
//                 return Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 40,
//                         child: Text(
//                           day,
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 60,
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 timePicker(day, "startTime");
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(5),
//                                 // width: 60,
//                                 // height: 30,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white, // Background color
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2,
//                                       blurRadius: 5,
//                                       offset: Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     timeRange!["startTime"].format(context),
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 timePicker(day, "endTime");
//                               },

//                               child: Container(
//                                 padding: EdgeInsets.all(5),
//                                 // width: 60,
//                                 // height: 30,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white, // Background color
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2,
//                                       blurRadius: 5,
//                                       offset: Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     timeRange["endTime"].format(context),
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         // width: 50, // Adjust the width as needed
//                         height: 38,
//                         child: LiteRollingSwitch(
//                           value: schedule,
//                           width: 95,
//                           textOn: 'Open',
//                           textOff: 'Close',
//                           colorOn: Colors.teal,
//                           colorOff: Colors.grey,
//                           iconOn: Icons.offline_bolt,
//                           iconOff: Icons.power_settings_new,
//                           // animationDuration: const Duration(milliseconds: 300),
//                           onChanged: (bool state) {
//                             print('turned ${(state) ? 'on' : 'off'}');
//                           },
//                           onDoubleTap: () {},
//                           onSwipe: () {},
//                           onTap: () {},
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//                 // Text("${timeRange.startTime.format(context)},${timeRange.endTime.format(context)}"),
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             // width: 100,
//             height: 40,
//             // color: Colors.red,
//             decoration: BoxDecoration(
//               color: Colors.teal,
//               border: Border.all(
//                 color: Colors.grey, // You can customize the border color
//                 // width: 2.0, // You can customize the border width
//               ),
//             ),

//             child: Text(
//               'Save Edits',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           )
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_final_fields

import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import DateFormat class

class HoursOfOperations extends StatefulWidget {
  const HoursOfOperations({Key? key}) : super(key: key);

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

  late Map<String, Map<String, dynamic>> operatingHours;

  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 3);

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize operatingHours with data from the provider
  //   var data = Provider.of<ServicesProvider>(context, listen: false);
  //   operatingHours = {
  //     for (var openingHour in data.BusinessData!.openingHours)
  //       openingHour.day: {
  //         "startTime": openingHour.openingHours.isNotEmpty
  //             ? openingHour.openingHours[0].startTime
  //             : TimeOfDay(hour: 0, minute: 0),
  //         "endTime": openingHour.openingHours.isNotEmpty
  //             ? openingHour.openingHours[0].endTime
  //             : TimeOfDay(hour: 0, minute: 0),
  //         "schedule": true,
  //       }
  //   };
  // }

  void initState() {
  super.initState();
  // Initialize operatingHours with data from the provider
  var data = Provider.of<ServicesProvider>(context, listen: false);
  
  // Check if openingHours is not null before iterating over it
  if (data.BusinessData != null && data.BusinessData!.openingHours != null) {
    operatingHours = {
      for (var openingHour in data.BusinessData!.openingHours!)
        openingHour.day!: {
          "startTime": openingHour.openingTime!.isNotEmpty
              ? openingHour.openingTime![0].startTime
              // ignore: prefer_const_constructors
              : TimeOfDay(hour: 0, minute: 0),
          "endTime": openingHour.openingTime!.isNotEmpty
              ? openingHour.openingTime![0].endTime
              : TimeOfDay(hour: 0, minute: 0),
          "schedule": true,
        }
    };
  }
}


// // Function to format TimeOfDay to a string in 12-hour format
// String _formatTime(TimeOfDay time) {
//   final format = DateFormat.jm(); // Use DateFormat class to format time
//   final dateTime = DateTime(2022, 1, 1, time.hour, time.minute);
//   return format.format(dateTime);
// }

// Function to format TimeOfDay to a string in 12-hour format
  String _formatTime(dynamic time) {
    if (time is TimeOfDay) {
      final format = DateFormat.jm(); // Use DateFormat class to format time
      final dateTime = DateTime(2022, 1, 1, time.hour, time.minute);
      return format.format(dateTime);
    } else {
      // If the time is already formatted as a string, return it directly
      return time.toString();
    }
  }

  void timePicker(String day, String time) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        setState(() {
          operatingHours[day]![time] = value;
        });
      }
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
                final day = _days[index];
                final timeRange = operatingHours[day];
                final bool schedule = timeRange!["schedule"];
                return Padding(
                  padding: const EdgeInsets.all(10),
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
                                if (schedule) {
                                  timePicker(day, "startTime");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                    timeRange["startTime"] != null
                                        ? _formatTime(timeRange["startTime"])
                                        : "Closed",
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
                                if (schedule) {
                                  timePicker(day, "endTime");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                    timeRange["endTime"] != null
                                        ? _formatTime(timeRange["endTime"])
                                        : "Closed",
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
                      // Container(
                      //   height: 38,
                      //   child: LiteRollingSwitch(
                      //     value: schedule,
                      //     width: 95,
                      //     textOn: 'Open',
                      //     textOff: 'Close',
                      //     colorOn: Colors.teal,
                      //     colorOff: Colors.grey,
                      //     iconOn: Icons.offline_bolt,
                      //     iconOff: Icons.power_settings_new,
                      //     onChanged: (bool state) {
                      //       setState(() {
                      //         operatingHours[day]!["schedule"] = state;
                      //       });
                      //     },
                      //     onDoubleTap: () {},
                      //     onSwipe: () {},
                      //     onTap: () {},
                      //   ),
                      // )

                      Container(
                        height: 38,
                        child: LiteRollingSwitch(
                          value: operatingHours[day]!["schedule"],
                          // value: operatingHours[day]!["schedule"] &&
                          //     operatingHours[day]!["startTime"] != null &&
                          //     operatingHours[day]!["endTime"] != null,
                          width: 95,
                          textOn: 'Open',
                          textOff: 'Close',
                          colorOn: Colors.teal,
                          colorOff: Colors.grey,
                          iconOn: Icons.offline_bolt,
                          iconOff: Icons.power_settings_new,
                          onChanged: (bool state) {
                            setState(() {
                              operatingHours[day]!["schedule"] = state;
                              if (!state) {
                                // If the user toggles to close, set startTime and endTime to null
                                operatingHours[day]!["startTime"] = null;
                                operatingHours[day]!["endTime"] = null;
                              }
                            });
                          },
                          onDoubleTap: () {},
                          onSwipe: () {},
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.teal,
              border: Border.all(
                color: Colors.grey,
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
