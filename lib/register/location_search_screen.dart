// ignore_for_file: prefer_const_declarations, use_build_context_synchronously

import 'dart:convert';

import 'package:backendapp/http.dart';
import 'package:backendapp/models/autocomplete_prediction_model.dart';
import 'package:backendapp/provider/registrationdata_provider.dart';
import 'package:backendapp/register/onboardingService.dart';
import 'package:backendapp/screens/dialoge.dart';
import 'package:backendapp/screens/location_list_tile.dart';
import 'package:backendapp/screens/network_utility.dart';
import 'package:backendapp/register/select_location.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import '../utils/constants.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
// import 'package:autocomplete_prediction.dart';

class SearchLocationScreen extends StatefulWidget {
  String businessUid;
  SearchLocationScreen({required  this.businessUid});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<AutoCompletePrediction> placePredictions = [];
  var selectedPlace;
  var st = "jh";
  double? latitude;
  double? longitude;
  String? locationName;

  void getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("serviceEnabled");
    // Location services are disabled, show a dialog or prompt to enable them
    // You can use a package like 'fluttertoast' or 'flutter_dialogs' to display a message
    // to the user indicating that location services need to be enabled.
    // Example using 'fluttertoast':
    // Fluttertoast.showToast(msg: 'Please enable location services.');

    // Handle the scenario where location services are not enabled
    
    return;
  }

  permission = await Geolocator.checkPermission();
  print(permission);
  print("permission");
  if (permission == LocationPermission.denied) {
    
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Handle the scenario where the user denies permission
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle the scenario where the user has permanently denied permission
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

 latitude = position.latitude;
 longitude = position.longitude;
 locationName = await NetworkCalling().getLocationName(latitude!,longitude!,"AIzaSyBIp8U5x3b2GVj1cjNU3N6funOz_tEUAdk");
 showConfirmationDialog(context,widget.businessUid,locationName,latitude: latitude,longitude: longitude);


  print(latitude);
  print(longitude);
  print(position);

  // Use the latitude and longitude in your application as needed
}

  Future placeSearch({query}) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {
          "input": query,
          "components":"country:IN",
          "key": "AIzaSyBIp8U5x3b2GVj1cjNU3N6funOz_tEUAdk"});
          print(uri);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response);
      print("response");
      final jsonResponse = json.decode(response.body)["predictions"] as List;

      List<AutoCompletePrediction> placePreds = [];
      for (var i = 0; i < jsonResponse.length; i++) {
        placePreds.add(AutoCompletePrediction.fromJson(jsonResponse[i]));
      }
      setState(() {
        placePredictions = placePreds;
      });
    }
    return null;
  }

  Future<Map<String, dynamic>> getPlaceId(String placeId) async{
    final apiKey = 'AIzaSyBIp8U5x3b2GVj1cjNU3N6funOz_tEUAdk';
    final uri = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey';
    try{
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200){
        final body = json.decode(response.body);
        final lat = body['result']['geometry']['location']['lat'];
        final lng = body['result']['geometry']['location']['lng'];
        print('Latitude: $lat, Longitude: $lng');
        return {'latitude':lat, 'longitude': lng};
      }else{
        throw Exception('Failed to get place details. Error ${response.statusCode}: ${response.reasonPhrase}');
      }
      
    }catch (e){
      throw Exception('Error: $e');

    }

  }


  @override
  Widget build(BuildContext context) {
    var data = Provider.of<RegistrationProvider>(context, listen: false);
    print("business uid in search screen ${widget.businessUid}");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: secondaryColor10LightTheme,
              child: Icon(Icons.location_on),
            ),
          ),
          title: const Text(
            "Provide your Location",
            style: TextStyle(color: textColorLightTheme,fontSize: 16 ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: secondaryColor10LightTheme,
                child: Icon(Icons.crop_square_sharp),
              ),
            )
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Form(
            child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryColor10LightTheme
                      // border: Border.all(
                      //   color: Colors.grey,
                      //   width: 1,
                      // ),
                      ),
                  child: TextFormField(
                    onChanged: (value) {
                      placeSearch(query: value);
                      print(value);
                    },
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Location",
                        prefixIcon: Icon(Icons.location_pin)),
                  ),
                ))),
        const Divider(
          height: 4,
          thickness: 3,
          color: secondaryColor10LightTheme,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // placeAutoComplete("dubai");
              // print("pressed");
              // placeSearch();
              // navigatorPush(context, AddService());
              
              // navigatorPush(context, MapScreen());
              getCurrentLocation();
              // setState(() {
              //   getCurrentLocation();
              //   showConfirmationDialog(context,locationName);
              // });
            
            },
            icon: const Icon(Icons.edit_location),
            label: const Text("Current Location ? click here",style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor20LightTheme,
                elevation: 0,
                minimumSize: const Size(0, 40),
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ),
        const Divider(
          height: 4,
          thickness: 3,
          color: secondaryColor10LightTheme,
        ),
        // Visibility(
        //   visible: locationName != null,
        //   child: Text(locationName.toString())
        //   ),
        Expanded(
          child: ListView.builder(
              itemCount: placePredictions.length,
              // itemCount: 1,
              itemBuilder: (context, index) => LocationListTile(
                    press: () async {
                      print(placePredictions[index].placeId);
                      selectedPlace = placePredictions[index];
                      final latlag = await getPlaceId(placePredictions[index].placeId);
                      print(latlag);
                      print("latlag");
                      showConfirmationDialog(context,widget.businessUid,placePredictions[index].description,latitude: latlag['latitude'],longitude:latlag['longitude'] );
                      //  showConfirmationDialog(context,locationName,latitude: latitude,longitude: longitude);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PlaceDetailsScreen(
                      //         place: placePredictions[index]),
                      //   ),
                      // );
                    },
                    // location: "Banaras, Dhaka, Bangladesh"
                    location: placePredictions[index].description,
                    // location: placePredictions[index]!
                  )),
        ),
        

        Visibility(
          visible: selectedPlace != null,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(selectedPlace?.description ?? ''),
                // Text(selectedPlace?.address ?? ''),
                // Text(selectedPlace?.phoneNumber ?? ''),
              ],
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                print(placePredictions);
                print(data.registrationData.keys);
                print(data.registrationData.values);
                print(data.registrationData["latitude"]);
                print(data.registrationData['aadhar_back']);
                // print(data.registrationData["images"]);
                // print(data.registrationData["aadhar_front"]);
              });
            },
            child: Text("press"))

        // LocationListTile(press: () {}, location: "Banaras, Dhaka, Bangladesh")
      ]),
    );
  }
}