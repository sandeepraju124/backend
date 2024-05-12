// import 'package:flutter/material.dart';

// class AmenitySelector extends StatefulWidget {
//   final List<String> amenities;
//   final Function(List<String>) onChanged;

//   AmenitySelector({required this.amenities, required this.onChanged});

//   @override
//   _AmenitySelectorState createState() => _AmenitySelectorState();
// }

// class _AmenitySelectorState extends State<AmenitySelector> {
//   List<String> _selectedAmenities = [];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Amenities:',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10.0),
//         Column(
//           children: widget.amenities.map((amenity) {
//             return CheckboxListTile(
//               title: Text(amenity),
//               value: _selectedAmenities.contains(amenity),
//               onChanged: (selected) {
//                 setState(() {
//                   if (selected!) {
//                     _selectedAmenities.add(amenity);
//                   } else {
//                     _selectedAmenities.remove(amenity);
//                   }
//                   widget.onChanged(_selectedAmenities);
//                 });
//               },
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class AmenitySelector extends StatefulWidget {
  final List<String> amenities;
  final Map<String, List<String>> subOptions;
  final Function(Map<String, List<String>>) onChanged;

  AmenitySelector({required this.amenities, required this.subOptions, required this.onChanged});

  @override
  _AmenitySelectorState createState() => _AmenitySelectorState();
}

class _AmenitySelectorState extends State<AmenitySelector> {
  Map<String, List<String>> _selectedAmenities = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var amenity in widget.amenities)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: Text(amenity),
                value: _selectedAmenities.containsKey(amenity) && _selectedAmenities[amenity]!.isNotEmpty,
                onChanged: (selected) {
                  setState(() {
                    if (!_selectedAmenities.containsKey(amenity)) {
                      _selectedAmenities[amenity] = [];
                    }
                    if (selected!) {
                      _selectedAmenities[amenity]!.add(amenity);
                    } else {
                      _selectedAmenities[amenity]!.remove(amenity);
                    }
                    widget.onChanged(_selectedAmenities);
                  });
                },
              ),
              if (widget.subOptions.containsKey(amenity))
                ...widget.subOptions[amenity]!.map((subOption) => Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: CheckboxListTile(
                    title: Text(subOption),
                    value: _selectedAmenities.containsKey(amenity) && _selectedAmenities[amenity]!.contains(subOption),
                    onChanged: (selected) {
                      setState(() {
                        if (!_selectedAmenities.containsKey(amenity)) {
                          _selectedAmenities[amenity] = [];
                        }
                        if (selected!) {
                          _selectedAmenities[amenity]!.add(subOption);
                        } else {
                          _selectedAmenities[amenity]!.remove(subOption);
                        }
                        widget.onChanged(_selectedAmenities);
                      });
                    },
                  ),
                )),
              SizedBox(height: 20.0),
            ],
          ),
      ],
    );
  }
}

class AmenitySelectorDemo extends StatefulWidget {
  @override
  _AmenitySelectorDemoState createState() => _AmenitySelectorDemoState();
}

class _AmenitySelectorDemoState extends State<AmenitySelectorDemo> {
  Map<String, List<String>> selectedAmenities = {};

  void handleAmenitiesChanged(Map<String, List<String>> amenities) {
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
      'Accepted Cards'
      // Add more amenities as needed...
    ];

    Map<String, List<String>> subOptions = {
      'Accepted Cards': ['Credit', 'Debt', 'It is not'],
      // Add more amenities with sub-options as needed...
    };

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AmenitySelector(
              amenities: amenities,
              subOptions: subOptions,
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Amenity Selector Demo'),
      ),
      body: AmenitySelectorDemo(),
    ),
  ));
}
