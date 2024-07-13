// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_print

import 'package:backendapp/register/onboardingService.dart';
import 'package:backendapp/register/profile_screen.dart';
import 'package:backendapp/register/profile_redirect.dart';
import 'package:backendapp/register/register.dart';
import 'package:backendapp/register/signup.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

class redirection extends StatelessWidget {
  const redirection({super.key});

  // const redirection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // CircularProgressIndicator shown during user loging
            return Center(
              child: CircularProgressIndicator(color: tgPrimaryColor),
            );
          } else if (snapshot.hasData) {
            // if user already login this screen shows
            // return OnboardingService();
            // return Homepage();
            // return ProfileRedirect();
            return ProfileRedirect();
          } else if (snapshot.hasError) {
            print("something went worng");
          } else {
            // if user not login this screen shows
            return SignUp();
            // LogIn();
          }
          return throw (e) {
            // print("through in redirection");
            print(e);
          };
        }));
  }
}
