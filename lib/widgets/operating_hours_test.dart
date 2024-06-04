// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class OperatingHoursScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<HoursProvider>(context);
//     final data = Provider.of<ServicesProvider>(context);
//     // data.BusinessData.

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Operating Hours'),
//       ),
//       body: ListView(
//         children: [
//           DayTimeSelector(day: 'Monday'),
//           DayTimeSelector(day: 'Tuesday'),
//           DayTimeSelector(day: 'Wednesday'),
//           DayTimeSelector(day: 'Thursday'),
//           DayTimeSelector(day: 'Friday'),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: ()async {
//           provider.printData();
//           String businessUid = await getBusinessUid(context);
//           data.postOperatingHours(provider.hours,businessUid);
//         },
//         child: Icon(Icons.save),
//       ),
//     );
//   }
// }

// class DayTimeSelector extends StatelessWidget {
//   final String day;

//   DayTimeSelector({required this.day});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<HoursProvider>(context);
//     final isClosed = provider.isClosed(day);
//     final isOpen24 = provider.isOpen24Hours(day);
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(day, style: TextStyle(fontSize: 20)),
//             Row(
//               children: [
//                 Expanded(
//                   child: isClosed
//                       ? Container()
//                       : TimeDropdown(
//                           value: provider.openTime(day),
//                           onChanged: (value) {
//                             provider.setOpenTime(day, value);
//                           },
//                         ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: isClosed
//                       ? Container()
//                       : TimeDropdown(
//                           value: provider.closeTime(day),
//                           onChanged: (value) {
//                             provider.setCloseTime(day, value);
//                           },
//                         ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Checkbox(
//                   value: isOpen24,
//                   onChanged: (value) {
//                     provider.setOpen24Hours(day, value ?? false);
//                   },
//                 ),
//                 Text('Open 24 hours'),
//                 Checkbox(
//                   value: isClosed,
//                   onChanged: (value) {
//                     provider.setClosed(day, value ?? false);
//                   },
//                 ),
//                 Text('Closed'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TimeDropdown extends StatelessWidget {
//   final String? value;
//   final void Function(String?) onChanged;

//   TimeDropdown({this.value, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       isExpanded: true,
//       value: value,
//       items: _times.map((time) {
//         return DropdownMenuItem<String>(
//           value: time,
//           child: Text(time),
//         );
//       }).toList(),
//       onChanged: onChanged,
//     );
//   }
// }

// final List<String> _times = [
//   '12:00 AM', '12:30 AM', '1:00 AM', '1:30 AM', '2:00 AM', '2:30 AM', '3:00 AM', '3:30 AM', '4:00 AM', '4:30 AM', '5:00 AM', '5:30 AM',
//   '6:00 AM', '6:30 AM', '7:00 AM', '7:30 AM', '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
//   '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM', '5:00 PM', '5:30 PM',
//   '6:00 PM', '6:30 PM', '7:00 PM', '7:30 PM', '8:00 PM', '8:30 PM', '9:00 PM', '9:30 PM', '10:00 PM', '10:30 PM', '11:00 PM', '11:30 PM',
//   '11:59 PM'
// ];

// class HoursProvider with ChangeNotifier {
//   Map<String, Map<String, dynamic>> hours = {
//     'Monday': {'open': '12:00 AM', 'close': '11:59 PM', 'open24': true, 'closed': false},
//     'Tuesday': {'open': '3:00 AM', 'close': '3:00 AM', 'open24': false, 'closed': false},
//     'Wednesday': {'open': '12:00 AM', 'close': '11:59 PM', 'open24': true, 'closed': false},
//     'Thursday': {'open': null, 'close': null, 'open24': false, 'closed': true},
//     'Friday': {'open': null, 'close': null, 'open24': false, 'closed': true},
//   };

//   bool isClosed(String day) => hours[day]!['closed'] as bool;

//   bool isOpen24Hours(String day) => hours[day]!['open24'] as bool;

//   String? openTime(String day) => hours[day]!['open'] as String?;

//   String? closeTime(String day) => hours[day]!['close'] as String?;

//   void setClosed(String day, bool value) {
//     hours[day]!['closed'] = value;
//     if (value) {
//       hours[day]!['open'] = null;
//       hours[day]!['close'] = null;
//       hours[day]!['open24'] = false;
//     }
//     notifyListeners();
//   }

//   void setOpen24Hours(String day, bool value) {
//     hours[day]!['open24'] = value;
//     if (value) {
//       hours[day]!['open'] = '12:00 AM';
//       hours[day]!['close'] = '11:59 PM';
//     } else {
//       hours[day]!['open'] = null;
//       hours[day]!['close'] = null;
//     }
//     notifyListeners();
//   }

//   void setOpenTime(String day, String? value) {
//     hours[day]!['open'] = value;
//     notifyListeners();
//   }

//   void setCloseTime(String day, String? value) {
//     hours[day]!['close'] = value;
//     notifyListeners();
//   }

//   void printData() {
//     hours.forEach((day, times) {
//       print('$day: Open - ${times['open']}, Close - ${times['close']}, 24 hours - ${times['open24']}, Closed - ${times['closed']}');
//     });
//   }
// }
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OperatingHoursScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ServicesProvider>(context);
    final hoursProvider = Provider.of<HoursProvider>(context, listen: false);

    // if (data.BusinessData!.operatingHours != null) {
    //   final openingHours = data.BusinessData!.operatingHours!.toMap();
    //   hoursProvider.updateHours(openingHours);
    // }

    // Use addPostFrameCallback to update hoursProvider after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data.BusinessData!.operatingHours != null) {
        final openingHours = data.BusinessData!.operatingHours!.toMap();
        hoursProvider.updateHours(openingHours);
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Operating Hours'),
        ),
        body: ListView(
          children: [
            DayTimeSelector(day: 'Monday'),
            DayTimeSelector(day: 'Tuesday'),
            DayTimeSelector(day: 'Wednesday'),
            DayTimeSelector(day: 'Thursday'),
            DayTimeSelector(day: 'Friday'),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () async {
              final provider =
                  Provider.of<HoursProvider>(context, listen: false);
              provider.printData();
              String businessUid = await getBusinessUid(context);
              bool isCheck =
                  await data.postOperatingHours(provider.hours, businessUid);
              if (isCheck) {
                showSnackBar(context, "Operating Hours updated successfully");
              }
            },
            child: Text('Update Operating Hours'),
          ),
        // FloatingActionButton(
        //   onPressed: () async {
        //     final provider = Provider.of<HoursProvider>(context, listen: false);
        //     provider.printData();
        //     String businessUid = await getBusinessUid(context);
        //     data.postOperatingHours(provider.hours, businessUid);
        //   },
        //   child: Icon(Icons.save),
        // ),
        );
  }
}

class DayTimeSelector extends StatelessWidget {
  final String day;

  DayTimeSelector({required this.day});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HoursProvider>(context);
    final isClosed = provider.isClosed(day);
    final isOpen24 = provider.isOpen24Hours(day);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(day, style: TextStyle(fontSize: 20)),
            Row(
              children: [
                Expanded(
                  child: isClosed
                      ? Container()
                      : TimeDropdown(
                          value: provider.openTime(day),
                          onChanged: (value) {
                            provider.setOpenTime(day, value);
                          },
                        ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: isClosed
                      ? Container()
                      : TimeDropdown(
                          value: provider.closeTime(day),
                          onChanged: (value) {
                            provider.setCloseTime(day, value);
                          },
                        ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isOpen24,
                  onChanged: (value) {
                    provider.setOpen24Hours(day, value ?? false);
                  },
                ),
                Text('Open 24 hours'),
                Checkbox(
                  value: isClosed,
                  onChanged: (value) {
                    provider.setClosed(day, value ?? false);
                  },
                ),
                Text('Closed'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeDropdown extends StatelessWidget {
  final String? value;
  final void Function(String?) onChanged;

  TimeDropdown({this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value,
      items: _times.map((time) {
        return DropdownMenuItem<String>(
          value: time,
          child: Text(time),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

final List<String> _times = [
  '12:00 AM',
  '12:30 AM',
  '1:00 AM',
  '1:30 AM',
  '2:00 AM',
  '2:30 AM',
  '3:00 AM',
  '3:30 AM',
  '4:00 AM',
  '4:30 AM',
  '5:00 AM',
  '5:30 AM',
  '6:00 AM',
  '6:30 AM',
  '7:00 AM',
  '7:30 AM',
  '8:00 AM',
  '8:30 AM',
  '9:00 AM',
  '9:30 AM',
  '10:00 AM',
  '10:30 AM',
  '11:00 AM',
  '11:30 AM',
  '12:00 PM',
  '12:30 PM',
  '1:00 PM',
  '1:30 PM',
  '2:00 PM',
  '2:30 PM',
  '3:00 PM',
  '3:30 PM',
  '4:00 PM',
  '4:30 PM',
  '5:00 PM',
  '5:30 PM',
  '6:00 PM',
  '6:30 PM',
  '7:00 PM',
  '7:30 PM',
  '8:00 PM',
  '8:30 PM',
  '9:00 PM',
  '9:30 PM',
  '10:00 PM',
  '10:30 PM',
  '11:00 PM',
  '11:30 PM',
  '11:59 PM'
];

class HoursProvider with ChangeNotifier {
  Map<String, Map<String, dynamic>> hours;

  HoursProvider({Map<String, Map<String, dynamic>>? initialHours})
      : hours = initialHours ??
            {
              'Monday': {
                'open': '12:00 AM',
                'close': '11:59 PM',
                'open24': true,
                'closed': false
              },
              'Tuesday': {
                'open': '3:00 AM',
                'close': '3:00 AM',
                'open24': false,
                'closed': false
              },
              'Wednesday': {
                'open': '12:00 AM',
                'close': '11:59 PM',
                'open24': true,
                'closed': false
              },
              'Thursday': {
                'open': null,
                'close': null,
                'open24': false,
                'closed': true
              },
              'Friday': {
                'open': null,
                'close': null,
                'open24': false,
                'closed': true
              },
            };

  bool isClosed(String day) => hours[day]!['closed'] as bool;

  bool isOpen24Hours(String day) => hours[day]!['open24'] as bool;

  String? openTime(String day) => hours[day]!['open'] as String?;

  String? closeTime(String day) => hours[day]!['close'] as String?;

  void setClosed(String day, bool value) {
    hours[day]!['closed'] = value;
    if (value) {
      hours[day]!['open'] = null;
      hours[day]!['close'] = null;
      hours[day]!['open24'] = false;
    }
    notifyListeners();
  }

  void setOpen24Hours(String day, bool value) {
    hours[day]!['open24'] = value;
    if (value) {
      hours[day]!['open'] = '12:00 AM';
      hours[day]!['close'] = '11:59 PM';
    } else {
      hours[day]!['open'] = null;
      hours[day]!['close'] = null;
    }
    notifyListeners();
  }

  void setOpenTime(String day, String? value) {
    hours[day]!['open'] = value;
    notifyListeners();
  }

  void setCloseTime(String day, String? value) {
    hours[day]!['close'] = value;
    notifyListeners();
  }

  void printData() {
    hours.forEach((day, times) {
      print(
          '$day: Open - ${times['open']}, Close - ${times['close']}, 24 hours - ${times['open24']}, Closed - ${times['closed']}');
    });
  }

  void updateHours(Map<String, Map<String, dynamic>> newHours) {
    hours = newHours;
    notifyListeners();
  }
}
