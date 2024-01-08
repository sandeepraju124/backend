// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;
// import 'package:permission_handler/permission_handler.dart' as perm;

// class MapPointerPage extends StatefulWidget {
//   const MapPointerPage({Key? key}) : super(key: key);

//   @override
//   _MapPointerPageState createState() => _MapPointerPageState();
// }

// class _MapPointerPageState extends State<MapPointerPage> {
//   // final _controller = GoogleMapController(); 
//   late loc.LocationData _currentLocation;
//   late LatLng _selectedLocation;

//   @override
//   void initState() {
//     super.initState();
//     _checkLocationPermission();
//   }

//   Future<void> _checkLocationPermission() async {
//     final status = await perm.Permission.location.request();
//     if (status != perm.PermissionStatus.granted) {
//       return;
//     }
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     final location = loc.Location();
//     final data = await location.getLocation();
//     setState(() {
//       _currentLocation = data;
//       _selectedLocation = LatLng(_currentLocation.latitude!, _currentLocation.longitude!);
//     });
//     _controller.animateCamera(CameraUpdate.newLatLng(_selectedLocation));
//     _controller.setMyLocationEnabled(true);
//   }

//   void _onMapLongPressed(LatLng position) {
//     setState(() {
//       _selectedLocation = position;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Location'),
//       ),
//       body: GoogleMap(
//         onMapCreated: (controller) => _controller = controller,
//         onLongPress: _onMapLongPressed,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0),
//           zoom: 16,
//         ),
//         myLocationEnabled: true,
//         markers: {
//           Marker(
//             markerId: MarkerId('selectedLocation'),
//             position: _selectedLocation,
//           ),
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           print('Selected Location: $_selectedLocation');
//         },
//         child: const Icon(Icons.check),
//       ),
//     );
//   }
// }
