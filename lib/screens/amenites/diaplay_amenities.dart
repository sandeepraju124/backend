// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AmenityScreen extends StatefulWidget {
//   @override
//   _AmenityScreenState createState() => _AmenityScreenState();
// }

// class _AmenityScreenState extends State<AmenityScreen> {
//   // List<String> amenities = [
//   //   "24/7 emergency service",
//   //   "Leak detection",
//   //   "Pipe repair",
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<ServicesProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Amenities'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: data.BusinessData?.amenities != null && data.BusinessData!.amenities!.isNotEmpty ? ListView.builder(
//           itemCount: data.BusinessData!.amenities!.length,
//           itemBuilder: (context, index) {
//             return AmenityTile(
//               amenity: data.BusinessData!.amenities![index],
//               onDelete: () {
//                 setState(() {
//                   // amenities.removeAt(index);
//                 });
//               },
//             );
//           },
//         ): Text("No amenities added yet"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add Amenity functionality
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class AmenityTile extends StatelessWidget {
//   final String amenity;
//   final VoidCallback onDelete;

//   const AmenityTile({
//     Key? key,
//     required this.amenity,
//     required this.onDelete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         title: Text(amenity),
//         // trailing: IconButton(
//         //   icon: Icon(Icons.delete),
//         //   onPressed: onDelete,
//         // ),
//       ),
//     );
//   }
// }

import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmenityScreen extends StatefulWidget {
  @override
  _AmenityScreenState createState() => _AmenityScreenState();
}

class _AmenityScreenState extends State<AmenityScreen> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ServicesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Amenities', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: data.BusinessData?.amenities != null &&
                data.BusinessData!.amenities!.isNotEmpty
            ? ListView.builder(
                itemCount: data.BusinessData!.amenities!.length,
                itemBuilder: (context, index) {
                  return AmenityTile(
                    amenity: data.BusinessData!.amenities![index],
                    onDelete: () {
                      _showDeleteConfirmationDialog(index);
                    },
                  );
                },
              )
            : Center(
                child: Text(
                  "No amenities added yet",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAmenityDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    var data = Provider.of<ServicesProvider>(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Amenity'),
          content: Text('Are you sure you want to delete this amenity?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  // Remove the amenity from the list and update provider
                  data.BusinessData!.amenities!.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddAmenityDialog() {
    final TextEditingController _controller = TextEditingController();
    var data = Provider.of<ServicesProvider>(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Amenity'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter new amenity',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    data.BusinessData!.amenities!.add(_controller.text);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          amenity,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
