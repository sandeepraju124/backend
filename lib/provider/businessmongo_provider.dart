
import 'package:backendapp/http.dart';
import 'package:backendapp/models/businessmongo_model.dart';
import 'package:flutter/material.dart';

class BusinessMongoProvider extends ChangeNotifier{

  BusinessMongoModels? _businessdata;
  BusinessMongoModels? get BusinessData =>  _businessdata;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future<void> getMongoBusinessData()async{
    _isLoading = true;
    try {
      var uri = "https://supernova1137.azurewebsites.net/mongo/business?business_uid=BOORET54634567890121";
      BusinessMongoModels data = await NetworkCalling().fetchMongoBusinessData(uri);
      print(data);
      _businessdata = data;
    }catch (e) {
      print('Error fetching mongo business data: $e');

    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

}