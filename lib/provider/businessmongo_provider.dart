
import 'package:backendapp/http.dart';
import 'package:backendapp/models/services_model.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';

class ServicesProvider extends ChangeNotifier{

  ServicesModels? _businessdata;
  ServicesModels? get BusinessData =>  _businessdata;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


// is loading for deleting
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;


  Future<void> getMongoBusinessData(String business_uid)async{
    _isLoading = true;
    try {
      // var uri = "https://supernova1137.azurewebsites.net/mongo/business?business_uid=HOMPLUS9PVd3F9W6NEW";
      var uri = "$baseUrl/mongo/business?business_uid=$business_uid";
      ServicesModels data = await NetworkCalling().fetchMongoBusinessData(uri);
      print("data from provider $data");
      // print("data");
      _businessdata = data;
    }catch (e) {
      print('Error fetching mongo business data: $e');
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteImage(String businessUid, String imageUrl) async {
    _isLoadingDelete = true;
    notifyListeners();
    try {
      var uri = '$baseUrl/mongo/business?business_uid=$businessUid&image_url=$imageUrl';
      Map<String,dynamic> response = await NetworkCalling().deleteImage(uri);
      print(response['statusCode']);
      print("response body");

      // http://127.0.0.1:5000/mongo/business?business_uid=HOMPLUmwIKNIYtST&image_url=https://chambersafe.blob.core.windows.net/slytherinsafestorage/HOMPLUmwIKNIYtST-4a18e43b-1106-4146-aeda-a6a4771cd6f3.jpg

      // After the PATCH request is successful, update the local data
      // For example:
      if (response['statusCode'] == 200) {
        getMongoBusinessData(businessUid);
        // Update the local data with the patched data
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // String? businessUid = prefs.getString('businessUid');
        // getBusinessData("business_uid", businessUid!);
        // print('Updated Business Data: $updatedData');
        return true;

        // _businessdata = updatedData;
        // Or you can update specific fields in the data
        // _businessdata[index] = updatedData;
      }else {
      // print('Failed to update business data: ${response.body}');
      return false; // Return false indicating failure
    }
      // For demonstration, let's print the updated data
      
    } catch (e) {
      print('Error updating business data: $e');
      return false;
    } finally {
      // Notify listeners after the data has been updated
      _isLoading = false;
      notifyListeners();
    }
  }
}