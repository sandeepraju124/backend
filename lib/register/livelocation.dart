// import 'package:backendapp/http.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';

// class LiveUserLocation extends ChangeNotifier{

//   double? latitude;
//   double? longitude;
//   String? locationName;


//   void getCurrentLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     print("serviceEnabled");
//     // Location services are disabled, show a dialog or prompt to enable them
//     // You can use a package like 'fluttertoast' or 'flutter_dialogs' to display a message
//     // to the user indicating that location services need to be enabled.
//     // Example using 'fluttertoast':
//     // Fluttertoast.showToast(msg: 'Please enable location services.');

//     // Handle the scenario where location services are not enabled
    
//     return;
//   }

//   permission = await Geolocator.checkPermission();
//   print(permission);
//   print("permission");
//   if (permission == LocationPermission.denied) {
    
//     permission = await Geolocator.requestPermission();
//     if (permission != LocationPermission.whileInUse &&
//         permission != LocationPermission.always) {
//       // Handle the scenario where the user denies permission
//       return;
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Handle the scenario where the user has permanently denied permission
//     return;
//   }

//   Position position = await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high,
//   );

//  latitude = position.latitude;
//  longitude = position.longitude;
//  locationName = await NetworkCalling().getLocationName(latitude!,longitude!,"AIzaSyBIp8U5x3b2GVj1cjNU3N6funOz_tEUAdk");
//  notifyListeners();

//   print(latitude);
//   print(longitude);
//   print(position);

//   // Use the latitude and longitude in your application as needed
// }

// }