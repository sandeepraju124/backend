// ignore_for_file: unused_import

import 'package:backendapp/graphs/datamodel.dart';
import 'package:backendapp/widgets/linechart.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:backendapp/screens/select_location.dart';
import 'package:backendapp/screens/add_service_screens/addService.dart';
import 'package:backendapp/screens/add_service_screens/amenities.dart';
import 'package:backendapp/screens/add_service_screens/amenities_2.dart';
import 'package:backendapp/screens/add_service_screens/multi_image_pick.dart';
import 'package:backendapp/screens/add_service_screens/type_ahead.dart';
import 'package:backendapp/screens/test.dart';
import 'package:backendapp/screens/processing.dart';
import 'package:backendapp/screens/hours.dart';
import 'package:backendapp/screens/location_search_screen.dart';
import 'package:backendapp/signin/register.dart';
import 'package:backendapp/signin/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: BusinessLineChart(yaxis: "reviews"),
      // home: SignUp(),
      home: Homepage(),
      // home:line(),
    );
  }
}

