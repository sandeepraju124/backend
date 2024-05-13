import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmenityScreen extends StatefulWidget {
  @override
  _AmenityScreenState createState() => _AmenityScreenState();
}

class _AmenityScreenState extends State<AmenityScreen> {
  // List<String> amenities = [
  //   "24/7 emergency service",
  //   "Leak detection",
  //   "Pipe repair",
  // ];
  

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ServicesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Amenities'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: data.BusinessData!.amenities!.length,
          itemBuilder: (context, index) {
            return AmenityTile(
              amenity: data.BusinessData!.amenities![index],
              onDelete: () {
                setState(() {
                  // amenities.removeAt(index);
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add Amenity functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AmenityTile extends StatelessWidget {
  final String amenity;
  final VoidCallback onDelete;

  const AmenityTile({
    Key? key,
    required this.amenity,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(amenity),
        // trailing: IconButton(
        //   icon: Icon(Icons.delete),
        //   onPressed: onDelete,
        // ),
      ),
    );
  }
}
