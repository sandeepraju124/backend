import 'package:backendapp/http.dart';
import 'package:backendapp/models/businessdata_models.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessDataProvider extends ChangeNotifier {
  List<BusinessDataModels>? _businessdata;
  List<BusinessDataModels>? get BusinessData => _businessdata;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

// this loading is for patch function
  bool _isLoadingPatch = false;
  bool get isLoadingPatch => _isLoadingPatch;

  Future<bool> getBusinessData(String key, String value) async {
    _isLoading = true;
    _businessdata = [];
    try {
      var uri = '$baseUrl/pg/business/where?$key=$value';
      List<BusinessDataModels> businessdata =
          await NetworkCalling().fetchBusinessData(uri);
      _businessdata = businessdata;
      print(businessdata);
      print("businessdata");
      return true;
    } catch (e) {
      print('Error fetching business data: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateBusinessData(Map<String, dynamic> updatedData) async {
    _isLoadingPatch = true;
    notifyListeners();
    try {
      var uri = '$baseUrl/pg/business';
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
        getBusinessData("business_uid", businessUid!);
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
      print("in finally");
      notifyListeners();
    }
  }


  void reset() {
    _businessdata = [];
    _isLoading = false;
    _isLoadingPatch = false;
    notifyListeners();
  }


}
