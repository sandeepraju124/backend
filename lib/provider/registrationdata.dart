

// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier{


  Map<String, dynamic> _registrationData =  {
    'businessName' : '',
    'businessEmail':'',
    'business_description':'',
    'contactInfo' : '',
    'address':'',
    'country':'',
    'latitude': '',
    'longitude': '',
    'profile_image_url':'',
    'category':'',
    'sub_category':'',

  };

  Map<String, dynamic> get registrationData => _registrationData;

  void updateBusinessData (Map<String,dynamic> data){
    print(data);
    data.forEach((key, value) {
      if (data.containsKey(key)){
        _registrationData[key] = value;
      }
    });
    //  {business_name: late, business_description: late, contact_information: 23456, country: india}
    print(_registrationData);
    print("_registrationData");

    notifyListeners();
  }




} 