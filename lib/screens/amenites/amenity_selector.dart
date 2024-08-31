import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/screens/amenites/amenites_list.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmenitySelector extends StatefulWidget {
  final List<String> amenities;
  final Map<String, List<String>> subOptions;
  final Function(Map<String, List<String>>) onChanged;

  AmenitySelector({
    required this.amenities,
    required this.subOptions,
    required this.onChanged,
  });

  @override
  _AmenitySelectorState createState() => _AmenitySelectorState();
}

class _AmenitySelectorState extends State<AmenitySelector> {
  Map<String, List<String>> _selectedAmenities = {};

  @override
  void initState() {
    super.initState();
    presentAmenitiesCheck();
  }

  Future<void> presentAmenitiesCheck() async {
    var presentAmenities = Provider.of<ServicesProvider>(context, listen: false)
        .BusinessData!
        .amenities;
    for (var amenity in widget.amenities) {
      if (presentAmenities!.contains(amenity)) {
        _selectedAmenities[amenity] = [amenity];
      } else {
        _selectedAmenities[amenity] = [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap:
          true, // Allows the ListView to be sized correctly within a scrollable parent
      physics:
          NeverScrollableScrollPhysics(), // Disables ListView's own scrolling
      children: [
        for (var amenity in widget.amenities)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: CheckboxListTile(
                  title: Text(
                    amenity,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.8,
                    ),
                  ),
                  value: _selectedAmenities.containsKey(amenity) &&
                      _selectedAmenities[amenity]!.isNotEmpty,
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
              ),
              if (widget.subOptions.containsKey(amenity))
                ...widget.subOptions[amenity]!.map(
                  (subOption) => Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: CheckboxListTile(
                      title: Text(subOption),
                      value: _selectedAmenities.containsKey(amenity) &&
                          _selectedAmenities[amenity]!.contains(subOption),
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
                  ),
                ),
              SizedBox(height: 20.0),
            ],
          ),
      ],
    );
  }
}
