import "dart:convert";

import "package:backendapp/http.dart";
import "package:backendapp/models/house_models.dart";
import "package:backendapp/utils/constants.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:developer';

import "package:shared_preferences/shared_preferences.dart";

class HouseProvider extends ChangeNotifier {

  List<HouseModels>? _houseData;
  bool _isLoading = false;

  List<HouseModels>? get houseData => _houseData;
  bool get isLoading => _isLoading;

  bool _isLoadingPatch = false;
  bool get isLoadingPatch => _isLoadingPatch;




  Future<void> fetchHouseData(String businessUid) async {
    print("fetchHouseData Called");  
    try {
      _isLoading = true;
      notifyListeners();

      var url = "$baseUrl/pg/house?business_uid=$businessUid";
      // var url = "$baseUrl/pg/house?business_uid=HOMPLUXrrIUyzX6k";
      // var url = "https://supernova1137.azurewebsites.net/overall_rating/PIZFOO4357128905678/6";
      final response = await http.get(Uri.parse(url));
      // print(response.body);
      log(response.body);
      print("log(response.body);");

      if (response.statusCode == 200) {
        // _houseData = json.decode(response.body);
        // _houseData = HouseModels.fromJson(json.decode(response.body));
        _houseData = houseModelsFromJson(response.body);
        // print(response.body);
        log(_houseData.toString());
        print("houseData");
        // _isLoading = false;
      } else {
        throw Exception('Failed to load review data');
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<bool> updateHouseData(Map<String, dynamic> updatedData) async {
    _isLoadingPatch = true;
    notifyListeners();
    try {
      // var uri = '$baseUrl/pg/business';
      var uri = '$baseUrl/pg/house';
      // print(updatedData);
      // print("updatedData");
      var response = await NetworkCalling().patchBusinessData(uri, updatedData);
      // print(response.body);
      // print("response body");

      // After the PATCH request is successful, update the local data
      // For example:
      if (response.statusCode == 200) {
        // Update the local data with the patched data
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? businessUid = prefs.getString('businessUid');
        fetchHouseData(businessUid!);
        // print('Updated Business Data: $updatedData');
        return true;

        // _businessdata = updatedData;
        // Or you can update specific fields in the data
        // _businessdata[index] = updatedData;
      } else {
        print('Failed to update business data: ${response.body}');
        return false; // Return false indicating failure
      }
      // For demonstration, let's print the updated data
    } catch (e) {
      print('Error updating business data: $e');
      return false;
    } finally {
      // Notify listeners after the data has been updated
      _isLoadingPatch = false;
      notifyListeners();
    }
  }
}

