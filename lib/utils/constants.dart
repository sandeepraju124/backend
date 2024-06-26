import "package:backendapp/provider/businessdata_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

const Color primaryColor = Color(0xFF006491);
const Color textColorLightTheme= Color(0xFF0D0D0E);

const Color secondaryColor80LightTheme= Color(0xFF202225);
const Color secondaryColor60LightTheme= Color(0xFF313336);
const Color secondaryColor40LightTheme= Color(0xFF585858);
const Color secondaryColor20LightTheme= Color(0xFF787F84);
const Color secondaryColor10LightTheme= Color(0xFFEEEEEE);
const Color secondaryColor5LightTheme= Color(0xFFF8F8F8);

// Teal,Blue Grey
const Color tgDarkPrimaryColor = Color(0xFF00796B);
const Color tgLightPrimaryColor = Color(0xFFB2DFDB);
const Color tgPrimaryColor = Color(0xFF009688);
const Color tgTextIcon = Color(0xFFFFFFFF);
const Color tgAccentColor = Color(0xFF607D8B);
const Color tgPrimaryText = Color(0xFF212121);
const Color tgSecondaryText = Color(0xFF757575);
const Color tgDividerColor = Color(0xFFBDBDBD);


const defaultPadding = 16.0;


String baseUrl = "https://supernova1137.azurewebsites.net/";


Widget RetangularBorderBox(TextMsg) {
  return Container(
    height: 30,
    width: double.infinity,
    decoration: BoxDecoration(
      color: tgDarkPrimaryColor,
      border: Border.all(color: secondaryColor20LightTheme),
    ),
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    child: Text(TextMsg, style: TextStyle(color: Colors.white),),
  );
}



const SizedBox sizedBox10 = SizedBox(height: 10,);
const SizedBox sizedBox5 = SizedBox(height: 5,);
const SizedBox sizedBox15 = SizedBox(height: 15,);
const SizedBox sizedBox20 = SizedBox(height: 20,);
const SizedBox sizedBox40 = SizedBox(height: 40,);
const SizedBox sizedBoxWidth20 = SizedBox(width: 20,);



void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}


// await prefs.setString('businessUid', businessUid);
// SharedPreferences prefs = await SharedPreferences.getInstance();
// String? businessUid = prefs.getString('businessUid');

Future<String> getBusinessUid(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? businessUid = prefs.getString('businessUid');

  if (businessUid == null) {
    var data = Provider.of<BusinessDataProvider>(context,listen: false);
    String businessUid = data.BusinessData![0].businessUid;
    await prefs.setString('businessUid', businessUid);
    return businessUid;
  }

  return businessUid;
}