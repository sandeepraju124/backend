import 'dart:convert';

import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/registrationdata_provider.dart';
import 'package:backendapp/register/postbusinessdatatest.dart';
import 'package:backendapp/register/postbusiness.dart';
import 'package:backendapp/register/waiting.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<void> showConfirmationDialog(context, businessUid, description,
    {double? latitude, double? longitude}) async {
  // var data = Provider.of<RegistrationProvider>(context, listen: false);
  print(businessUid);
  print("businessUid from dialoug page");
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10,
        title: Text('Confirm Location'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Confirm'),
            onPressed: () async {
              Map<String, dynamic> latlong = {
                'business_uid': businessUid,
                "latitude": latitude,
                "longitude": longitude
              };

              // Call the update method from the provider


              var uri = '$baseUrl/pg/business';

              var url = Uri.parse(uri);
              final headers = {'Content-Type': 'application/json'};
              var response = await http.patch(url,
                  body: jsonEncode(latlong), headers: headers);
                   if (response.statusCode == 200) {
                showSnackBar(context, "Location is Updated Sucessfully");
                Navigator.pop(context);
              }
              // data.updateBusinessData(latlong);

              // Perform actions on location confirmation
              // Navigator.of(context).pop();
              // navigatorPush(context, PostBusiness());
              navigatorPush(context, WaitingScreen());
            },
          ),
        ],
      );
    },
  );
}
