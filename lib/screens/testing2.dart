import 'package:backendapp/screens/testing.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Amenity Selector Demo'),
        ),
        body: AmenitySelectorDemo(),
      ),
    );
  }
}

class AmenitySelectorDemo extends StatefulWidget {
  @override
  _AmenitySelectorDemoState createState() => _AmenitySelectorDemoState();
}

class _AmenitySelectorDemoState extends State<AmenitySelectorDemo> {
  List<String> selectedAmenities = [];

  void handleAmenitiesChanged(List<String> amenities) {
    setState(() {
      selectedAmenities = amenities;
    });
  }

  void printSelectedAmenities() {
    print(selectedAmenities);
  }

  @override
  Widget build(BuildContext context) {
    List<String> amenities = [
      'Outdoor seating',
      'WiFi',
      'Parking availability',
      'Takeout',
      'Delivery',
      'Reservations',
      // Add more amenities as needed...
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AmenitySelector(
              amenities: amenities,
              onChanged: handleAmenitiesChanged,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: printSelectedAmenities,
              child: Text('Print Selected Amenities'),
            ),
          ],
        ),
      ),
    );
  }
}

