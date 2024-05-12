import 'package:flutter/material.dart';

class AmenitySelector extends StatefulWidget {
  final List<String> amenities;
  final Function(List<String>) onChanged;

  AmenitySelector({required this.amenities, required this.onChanged});

  @override
  _AmenitySelectorState createState() => _AmenitySelectorState();
}

class _AmenitySelectorState extends State<AmenitySelector> {
  List<String> _selectedAmenities = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Amenities:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Column(
          children: widget.amenities.map((amenity) {
            return CheckboxListTile(
              title: Text(amenity),
              value: _selectedAmenities.contains(amenity),
              onChanged: (selected) {
                setState(() {
                  if (selected!) {
                    _selectedAmenities.add(amenity);
                  } else {
                    _selectedAmenities.remove(amenity);
                  }
                  widget.onChanged(_selectedAmenities);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
