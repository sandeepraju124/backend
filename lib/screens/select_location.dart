import 'package:backendapp/screens/add_service_screens/addService.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../utils/navigators.dart';

const String kGoogleApiKey = 'AIzaSyBIp8U5x3b2GVj1cjNU3N6funOz_tEUAdk';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  TextEditingController _searchController = TextEditingController();
  final _placesApiClient = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  LatLng _selectedLocation = LatLng(0, 0);
  
  

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _searchLocation() async {
    final placesResponse = await _placesApiClient.searchByText(_searchController.text);
    final firstPlace = placesResponse.results.first;
    final detailsResponse = await _placesApiClient.getDetailsByPlaceId(firstPlace.placeId);
    final location = detailsResponse.result.geometry!.location;
    _selectedLocation = LatLng(location.lat, location.lng);
    _mapController!.animateCamera(CameraUpdate.newLatLng(_selectedLocation));
    setState(() {});
  }

  void _onMarkerDragEnd(LatLng position) {
    _selectedLocation = position;
    setState(() {});
  }

  double get latitude => _selectedLocation.latitude;
  double get longitude => _selectedLocation.longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: tgAccentColor,
        title: Text('Select your location'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Location',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _searchLocation,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 200,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(17.4875, 78.3953),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: _selectedLocation,
                  draggable: true,
                  onDragEnd: _onMarkerDragEnd,
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Latitude: ${_selectedLocation.latitude}, Longitude: ${_selectedLocation.longitude}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
        
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          navigatorPush(context,AddService(lat: _selectedLocation.latitude.toString(),lang: _selectedLocation.longitude.toString(),) );
        },
        child: Container(
          height: 55,
          width: double.infinity,
          color: tgAccentColor,
          child: Center(child: Text("Select", style: TextStyle(color: Colors.white, fontSize: 17),)),
        ),
      ),
    );
  }
}
