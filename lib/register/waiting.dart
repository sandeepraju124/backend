// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/register/profile_screen.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String WaitingMsg =
        "Thank you for your submission. Please wait patiently while our team verifies the details. Rest assured, we will notify you promptly once the verification process is complete. Your patience is appreciated.";
    return Scaffold(
      backgroundColor: Color(0xFFEFF1FE),
      body: Center(
          child:
              // Text("test")
              Image.asset('assets/3255337.jpg')),
      bottomNavigationBar: InkWell(
        onTap: () {},
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
              color: tgAccentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Waiting",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: 20,),
                Text(WaitingMsg,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    // navigatorPush(context, Homepage());
                    navigatorReplace(context, ProfileScreen());
                  },
                  child: Text("click"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
