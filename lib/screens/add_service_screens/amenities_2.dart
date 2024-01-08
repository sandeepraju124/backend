import 'package:flutter/material.dart';

class AmenitiesSelection extends StatefulWidget {
  @override 
  _AmenitiesSelectionState createState() => _AmenitiesSelectionState();
}

class _AmenitiesSelectionState extends State<AmenitiesSelection> {
  final List<String> _amenities =  ["Pool","Gym","Breakfast",
                                    "Free Wifi","Spa","Parking","Bar",
                                    "Restaurant","Room Service","Air Conditioning",
                                    "Pet Friendly",];

  final List<String> _selectedAmenities = [];
  Color? myColor = Colors.blue;
  Color defaultColor = Colors.grey;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("ndd"),
          Expanded(
            child: Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
              child: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 0.8,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration:const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Amenities",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                            child: GridView.builder(
                              // padding: EdgeInsets.all(10),
                              controller: scrollController,
                              itemCount: _amenities.length,
                              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                String amenity = _amenities[index];
                                bool isSelected = _selectedAmenities.contains(amenity);
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedAmenities.remove(amenity);
                                      } else {
                                        _selectedAmenities.add(amenity);
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: myColor ?? defaultColor,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: isSelected ? Colors.blue[50] : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        amenity,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: isSelected ? Colors.blue : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            "Selected Amenities: ${_selectedAmenities.join(', ')}",
                             style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
