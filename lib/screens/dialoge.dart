import 'package:backendapp/provider/registrationdata_provider.dart';
import 'package:backendapp/register/postbusinessdatatest.dart';
import 'package:backendapp/register/postbusiness.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showConfirmationDialog(context, description,{double? latitude, double? longitude}) async {
  var data = Provider.of<RegistrationProvider>(context, listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(elevation: 10,
      
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
            onPressed: () {
              Map<String,dynamic> latlong ={
                "latitude":latitude,
                "longitude": longitude
              };
              data.updateBusinessData(latlong);
              // Perform actions on location confirmation
              // Navigator.of(context).pop();
              // navigatorPush(context, PostBusiness());
              navigatorPush(context, PostBusinessPage());
            },
          ),
        ],
      );
    },
  );
}
