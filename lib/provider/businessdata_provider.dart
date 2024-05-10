import 'package:backendapp/http.dart';
import 'package:backendapp/models/businessdata_models.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';

class BusinessDataProvider extends ChangeNotifier{

  List<BusinessDataModels>? _businessdata;
  List<BusinessDataModels>? get BusinessData => _businessdata;
  bool _isLoading = false;
   bool get isLoading => _isLoading;

  Future<void> getBusinessData(String key, String value)async{
    _isLoading = true;
    _businessdata = [];
    try{
      var uri = '$baseUrl/pg/business/where?$key=$value';
      List<BusinessDataModels> businessdata = await NetworkCalling().fetchBusinessData(uri);
      _businessdata = businessdata;
      print(businessdata);
      print("businessdata");
    }catch (e) {
      print('Error fetching business data: $e');

    }finally{
      _isLoading = false;
      notifyListeners();

    }

  }

}