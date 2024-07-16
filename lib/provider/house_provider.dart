import "dart:convert";

import "package:backendapp/models/house_models.dart";
import "package:backendapp/utils/constants.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:developer';

class HouseProvider extends ChangeNotifier {

  List<HouseModels>? _houseData;
  bool _isLoading = false;

  List<HouseModels>? get houseData => _houseData;
  bool get isLoading => _isLoading;




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
}

