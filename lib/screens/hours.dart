import 'package:flutter/material.dart';

class BusinessHoursWidget extends StatefulWidget {
  @override
  _BusinessHoursWidgetState createState() => _BusinessHoursWidgetState();
}

class _BusinessHoursWidgetState extends State<BusinessHoursWidget> {
  Map<String, List<String>> businessHours = {
    'Monday': ['Closed', 'Closed'],
    'Tuesday': ['Closed', 'Closed'],
    'Wednesday': ['Closed', 'Closed'],
    'Thursday': ['Closed', 'Closed'],
    'Friday': ['Closed', 'Closed'],
    'Saturday': ['Closed', 'Closed'],
    'Sunday': ['Closed', 'Closed'],
  };

  List<String> hoursList = [    'Closed',    'Open 24 hours',    '1:00 AM',    '2:00 AM',    '3:00 AM',    '4:00 AM',    '5:00 AM',    '6:00 AM',    '7:00 AM',    '8:00 AM',    '9:00 AM',    '10:00 AM',    '11:00 AM',    '12:00 PM',    '1:00 PM',    '2:00 PM',    '3:00 PM',    '4:00 PM',    '5:00 PM',    '6:00 PM',    '7:00 PM',    '8:00 PM',    '9:00 PM',    '10:00 PM',    '11:00 PM',    '12:00 AM',  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: businessHours.length,
        itemBuilder: (context, index) {
          String day = businessHours.keys.elementAt(index);
          List<String> hours = businessHours[day]!;
          return ListTile(
            title: Text(day),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: hours[0],
                  onChanged: (String? newValue) {
                    setState(() {
                      hours[0] = newValue!;
                    });
                  },
                  items: hoursList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: hours[1],
                  onChanged: (String? newValue) {
                    setState(() {
                      hours[1] = newValue!;
                    });
                  },
                  items: hoursList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
