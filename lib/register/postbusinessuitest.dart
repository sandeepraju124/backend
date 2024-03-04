// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:backendapp/provider/registrationdata.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class postbusinesstest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<RegistrationProvider>(context);
    bool _isLoading = false;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: Color(0xFFEFF0F7),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: Image.file(
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                      File(data.registrationData['profile_image_url'])),
                  // child: Image.asset(
                  //   'assets/teamwork.jpg',
                  //   width: double.infinity,
                  //   height: 220,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Business Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['businessName'],
                          // "Sandy Plumber",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Discription",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['business_description'],
                          // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printerpsum.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Home Services > Mobile Home Repair",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['businessEmail'],
                          // "sandeepraju124@gmail.com",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          // data.registrationData['contactInfo'],
                          "Contact",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          // "9912277968",
                          data.registrationData['contactInfo'].toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['address'],
                          // "21302 Sipes Ridges, Sammymouth, RI 10106-8208",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Latitude and Longitude",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  data.registrationData['latitude'].toString(),
                                  // "12.211",
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  data.registrationData['longitude'].toString(),
                                  // "23.013",
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            )
                            // OutlinedBox(text: "12.211"),
                            // OutlinedBox(text: "23.013"),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            // signup();
            // navigatorPush(context,AddService() );
            // navigatorPush(context,SearchLocationScreen() );
          },
          child: Container(
            height: 55,
            width: double.infinity,
            color: tgAccentColor,
            child: Center(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ))
                    : Text(
                        "Create Business",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
          ),
        ),
      ),
    );
  }
}
