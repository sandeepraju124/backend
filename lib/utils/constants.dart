import "package:backendapp/provider/businessdata_provider.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:intl/intl.dart';

const Color primaryColor = Color(0xFF006491);
const Color textColorLightTheme = Color(0xFF0D0D0E);

const Color secondaryColor80LightTheme = Color(0xFF202225);
const Color secondaryColor60LightTheme = Color(0xFF313336);
const Color secondaryColor40LightTheme = Color(0xFF585858);
const Color secondaryColor20LightTheme = Color(0xFF787F84);
const Color secondaryColor10LightTheme = Color(0xFFEEEEEE);
const Color secondaryColor5LightTheme = Color(0xFFF8F8F8);

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
    child: Text(
      TextMsg,
      style: TextStyle(color: Colors.white),
    ),
  );
}

const SizedBox sizedBox10 = SizedBox(
  height: 10,
);
const SizedBox sizedBox5 = SizedBox(
  height: 5,
);
const SizedBox sizedBox15 = SizedBox(
  height: 15,
);
const SizedBox sizedBox20 = SizedBox(
  height: 20,
);
const SizedBox sizedBox40 = SizedBox(
  height: 40,
);
const SizedBox sizedBoxWidth20 = SizedBox(
  width: 20,
);

void showSnackBar(BuildContext context, String message) {
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

// String businessUid = await getBusinessUid(context);
Future<String> getBusinessUid(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? businessUid = prefs.getString('businessUid');

  if (businessUid == null) {
    var data = Provider.of<BusinessDataProvider>(context, listen: false);
    String businessUid = data.BusinessData![0].businessUid;
    await prefs.setString('businessUid', businessUid);
    return businessUid;
  }

  return businessUid;
}

// String? userId = await getUserId();
Future<String?> getUserId() async {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  // Return the userId (UID) if the user is signed in
  if (user != null) {
    return user.uid;
  } else {
    // User is not signed in
    print('No user is currently signed in.');
    return null;
  }
}



String formatCreatedAt(String createdAt) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'').parseUtc(createdAt).toLocal();

  Duration difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }
}



Widget customStars(int rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(
      5, // Always generate 5 stars
          (index) => Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 7, top: 10),
        child: Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            color: index < rating ? tgDarkPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black, width: 0.3),
          ),
          child: Icon(
            Icons.star,
            color: index < rating ? Colors.white : Colors.black,
            size: 12,
          ),
        ),
      ),
    ),
  );
}

