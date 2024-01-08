import 'dart:convert';

import 'package:backendapp/models/autocomplete_prediction_model.dart';
import 'package:backendapp/screens/add_service_screens/addService.dart';
import 'package:backendapp/screens/dialoge.dart';
import 'package:backendapp/screens/location_list_tile.dart';
import 'package:backendapp/screens/network_utility.dart';
import 'package:backendapp/screens/select_location.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import '../utils/constants.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
// import 'package:autocomplete_prediction.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<AutoCompletePrediction> placePredictions = [];
  var selectedPlace;
  var st = "jh";

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


  @override
  Widget build(BuildContext context) {
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
            "Clam your Business",
            style: TextStyle(color: textColorLightTheme),
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
      body: Column(children: [
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
              navigatorPush(context, MapScreen());

            },
            icon: const Icon(Icons.edit_location),
            label: const Text("Not listed ? click here"),
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
        Expanded(
          child: ListView.builder(
              itemCount: placePredictions.length,
              // itemCount: 1,
              itemBuilder: (context, index) => LocationListTile(
                    press: () {
                      print(placePredictions[index].placeId);
                      selectedPlace = placePredictions[index];
                      showConfirmationDialog(context,placePredictions[index].description);
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
              });
            },
            child: Text("press"))

        // LocationListTile(press: () {}, location: "Banaras, Dhaka, Bangladesh")
      ]),
    );
  }
}
