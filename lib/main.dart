// ignore_for_file: unused_import, prefer_const_constructors
import 'package:backendapp/firebase_options.dart';
import 'package:backendapp/register/postbusinessuitest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:backendapp/graphs/datamodel.dart';
import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/provider/registrationdata.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/widgets/linechart.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:backendapp/register/select_location.dart';
import 'package:backendapp/register/addService.dart';
import 'package:backendapp/screens/add_service_screens/amenities.dart';
import 'package:backendapp/screens/add_service_screens/amenities_2.dart';
import 'package:backendapp/screens/add_service_screens/multi_image_pick.dart';
import 'package:backendapp/screens/add_service_screens/type_ahead.dart';
import 'package:backendapp/screens/test.dart';
import 'package:backendapp/screens/processing.dart';
import 'package:backendapp/screens/hours.dart';
import 'package:backendapp/register/location_search_screen.dart';
import 'package:backendapp/register/register.dart';
import 'package:backendapp/register/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider<RegistrationProvider>(
      create: (_) => RegistrationProvider() ,
    ),
    ChangeNotifierProvider<AskCommunityProvider>(
      create: (_) => AskCommunityProvider() ,
    )
    ],
    
    child: const MyApp()));
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
      // home: Homepage(),
      home:redirection(),
      // home:postbusinesstest(),
    );
  } 
}

