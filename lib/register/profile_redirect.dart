// ignore_for_file: prefer_const_constructors

import 'package:backendapp/register/profile_screen.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRedirect extends StatelessWidget {
  const ProfileRedirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("in stream");
    return StreamBuilder<String?>(
      stream: SharedPreferences.getInstance()
          .then((prefs) => prefs.getString('businessUid'))
          .asStream(),
      builder: (context, snapshot) {
        // print("in stream");
        if (snapshot.connectionState == ConnectionState.waiting) {
          // print("in stream 17");
          // Wait for the shared preferences to load
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // print("in stream 25");
          // If businessUid is present in shared preferences, navigate to homepage
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return Homepage();
          } else {
            // print("in stream 30");
            // If businessUid is not present, navigate to ProfileRedirect page
            return ProfileScreen();
          }
        }
      },
    );
  }
}
