// import 'dart:convert';

// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/provider/registrationdata_provider.dart';
// import 'package:backendapp/register/postbusinessdatatest.dart';
// import 'package:backendapp/register/postbusiness.dart';
// import 'package:backendapp/register/waiting.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:backendapp/utils/navigators.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// Future<void> showConfirmationDialog(context, businessUid, description,
//     {double? latitude, double? longitude}) async {
//   // var data = Provider.of<RegistrationProvider>(context, listen: false);
//   print(businessUid);
//   print("businessUid from dialoug page");
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         elevation: 10,
//         title: Text('Confirm Location'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(description),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text('Confirm', ),
//             onPressed: () async {
//               Map<String, dynamic> latlong = {
//                 'business_uid': businessUid,
//                 "latitude": latitude,
//                 "longitude": longitude
//               };

//               // Call the update method from the provider

//               var uri = '$baseUrl/pg/business';

//               var url = Uri.parse(uri);
//               final headers = {'Content-Type': 'application/json'};
//               var response = await http.patch(url,
//                   body: jsonEncode(latlong), headers: headers);
//                    if (response.statusCode == 200) {
//                 showSnackBar(context, "Location is Updated Sucessfully");
//                 Navigator.pop(context);
//               }
//               // data.updateBusinessData(latlong);

//               // Perform actions on location confirmation
//               // Navigator.of(context).pop();
//               // navigatorPush(context, PostBusiness());
//               navigatorPush(context, WaitingScreen());
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:backendapp/register/waiting.dart';

Future<void> showConfirmationDialog(
    BuildContext context, String businessUid, String description,
    {double? latitude, double? longitude}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Confirm Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: tgDarkPrimaryColor,
                size: 36,
              ),
              SizedBox(height: 16),
              Text(
                description,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 24),
              Text(
                'Is this the correct location?',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[700]),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Confirm', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: tgDarkPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () async {
              Map<String, dynamic> latlong = {
                'business_uid': businessUid,
                "latitude": latitude,
                "longitude": longitude
              };

              var uri = '$baseUrl/pg/business';
              var url = Uri.parse(uri);
              final headers = {'Content-Type': 'application/json'};
              var response = await http.patch(url,
                  body: jsonEncode(latlong), headers: headers);

              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Location is Updated Successfully"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
                Navigator.pop(context);
                navigatorPush(context, WaitingScreen());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Failed to update location. Please try again."),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
