import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OperatingHoursScreen(),
    );
  }
}

class OperatingHoursScreen extends StatefulWidget {
  @override
  _OperatingHoursScreenState createState() => _OperatingHoursScreenState();
}

class _OperatingHoursScreenState extends State<OperatingHoursScreen> {
  List<String> daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  Map<String, TimeRange> operatingHours = {
    "Monday": TimeRange(
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
    ),
    "Tuesday": TimeRange(
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
    ),
    "Wednesday": TimeRange(
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
    ),
    "Thursday": TimeRange(
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
    ),
    "Friday": TimeRange(
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
    ),
    "Saturday": TimeRange(
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
    ),
    "Sunday": TimeRange(
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hours of Operation"),
      ),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          final day = daysOfWeek[index];
          final timeRange = operatingHours[day];
          return ListTile(
            title: Text(day),
            subtitle: Text(
              '${timeRange?.startTime.format(context)} - ${timeRange?.endTime.format(context)}',
            ),
            trailing: TextButton(
              onPressed: () => _showTimeRangePicker(day, timeRange!),
              child: Text("Change Hours"),
            ),
          );
        },
      ),
    );
  }

  void _showTimeRangePicker(String day, TimeRange timeRange) async {
    TimeRange result = await showTimeRangePicker(
      context: context,
      start: timeRange.startTime,
      end: timeRange.endTime,
    );

    if (result != null) {
      setState(() {
        operatingHours[day] = result;
      });
    }
  }
}
