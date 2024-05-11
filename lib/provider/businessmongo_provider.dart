
import 'package:backendapp/http.dart';
import 'package:backendapp/models/services_model.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';

class ServicesProvider extends ChangeNotifier{

  ServicesModels? _businessdata;
  ServicesModels? get BusinessData =>  _businessdata;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future<void> getMongoBusinessData(String business_uid)async{
    _isLoading = true;
    try {
      var uri = "https://supernova1137.azurewebsites.net/mongo/business?business_uid=HOMPLUS9PVd3F9W6NEW";
      // var uri = "$baseUrl/mongo/business?business_uid=$business_uid";
      ServicesModels data = await NetworkCalling().fetchMongoBusinessData(uri);
      // print(data);
      // print("data");
      _businessdata = data;
    }catch (e) {
      print('Error fetching mongo business data: $e');
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}