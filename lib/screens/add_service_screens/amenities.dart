import 'package:flutter/material.dart';

class amenities extends StatefulWidget {
  const amenities({super.key});

  @override
  State<amenities> createState() => _amenitiesState();
}

class _amenitiesState extends State<amenities> {

  List<String> _selectedAmenities = [];

  void _toggleAmenities(String amenities){
      setState(() {
        if(_selectedAmenities.contains(amenities)){
            _selectedAmenities.remove(amenities);
        }else{
          _selectedAmenities.add(amenities);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
        const SizedBox(height: 16),
        const Padding(
         padding: EdgeInsets.symmetric(horizontal: 16),
         child: Text("Select amenities",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
          ),
          const SizedBox(height: 16),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              _buildAmenityCheckbox("Parking","assets/pool.png"),
              _buildAmenityCheckbox("Gym","assets/pool.png"),
              _buildAmenityCheckbox("Breakfast","assets/pool.png"),
              _buildAmenityCheckbox("Free Wifi","assets/pool.png"),
              _buildAmenityCheckbox("Pet Friendly","assets/pool.png"),
            ],

          )
      ],)),
    );
  }

  Widget _buildAmenityCheckbox(String title, String icon){
  bool _isSelected = _selectedAmenities.contains(title);
  return CheckboxListTile(
    value:_isSelected ,
    onChanged: (_)=>_toggleAmenities(title),
    title: Row(children: [
      Image.asset(
            icon,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
    ]),
  );
}
}


