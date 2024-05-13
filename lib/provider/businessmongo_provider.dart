import 'dart:convert';
import 'dart:io';

import 'package:backendapp/http.dart';
import 'package:backendapp/models/services_model.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class ServicesProvider extends ChangeNotifier {
  ServicesModels? _businessdata;
  ServicesModels? get BusinessData => _businessdata;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

// is loading for deleting
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;

// is loading for upload images
  bool _isLoadingUpload = false;
  bool get isLoadingUpload => _isLoadingUpload;

  Future<void> getMongoBusinessData(String business_uid) async {
    _isLoading = true;
    try {
      // var uri = "https://supernova1137.azurewebsites.net/mongo/business?business_uid=HOMPLUS9PVd3F9W6NEW";
      var uri = "$baseUrl/mongo/business?business_uid=$business_uid";
      ServicesModels data = await NetworkCalling().fetchMongoBusinessData(uri);
      print("data from provider $data");
      // print("data");
      _businessdata = data;
    } catch (e) {
      print('Error fetching mongo business data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteImage(String businessUid, String imageUrl) async {
    _isLoadingDelete = true;
    notifyListeners();
    try {
      var uri =
          '$baseUrl/mongo/business?business_uid=$businessUid&image_url=$imageUrl';
      Map<String, dynamic> response = await NetworkCalling().deleteImage(uri);
      print(response['statusCode']);
      print("response body");

      // http://127.0.0.1:5000/mongo/business?business_uid=HOMPLUmwIKNIYtST&image_url=https://chambersafe.blob.core.windows.net/slytherinsafestorage/HOMPLUmwIKNIYtST-4a18e43b-1106-4146-aeda-a6a4771cd6f3.jpg

      if (response['statusCode'] == 200) {
        getMongoBusinessData(businessUid);
        return true;
        // _businessdata[index] = updatedData;
      } else {
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

  Future<bool> postAmenities(String businessUid, List<String> amenitiesToAddOrUpdate, List<String> amenitiesToRemove) async {
  var url = Uri.parse('$baseUrl/mongo/business');

  // var data = {
  //   "business_uid": businessUid,
  //   "amenities": amenities,
  // };

  var data = {
    "business_uid": businessUid,
    "amenitiesToAddOrUpdate": amenitiesToAddOrUpdate,
    "amenitiesToRemove": amenitiesToRemove,
  };

  try {
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      print('Amenities posted successfully');
      getMongoBusinessData(businessUid);
      return true;

    } else {
      // Handle other status codes (e.g., 404, 500)
      print('Failed to post amenities. Status code: ${response.statusCode}');
      return false;
    }
  } catch (error) {
    // Handle any errors that occur during the HTTP request
    print('Error occurred: $error');
    return false;
  }
}

  Future<bool> uploadImagesToServer(
      List<File> images, String businessUid) async {
    _isLoadingUpload = true;
    notifyListeners();
    try {
      final url = Uri.parse(
          'https://supernova1137.azurewebsites.net/post_multiple_images');
      var request = http.MultipartRequest('POST', url);
      request.fields['business_uid'] = businessUid;
      if (images.isNotEmpty) {
        for (File image in images) {
          request.files
              .add(await http.MultipartFile.fromPath('images', image.path));
        }
      }
      var response = await request.send();
      print(response);

      // Check the status code of the response
      if (response.statusCode == 200) {
        print('Images uploaded successfully');
        getMongoBusinessData(businessUid);
        return true;
      } else {
        print('Failed to upload images. Status code: ${response.statusCode}');
        return false;
      }
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
