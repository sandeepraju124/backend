// ignore_for_file: unused_import, prefer_const_constructors
import 'package:backendapp/firebase_options.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/provider/insights_provider.dart';
import 'package:backendapp/register/onboardingtest.dart';
import 'package:backendapp/register/postbusiness.dart';
import 'package:backendapp/register/waiting.dart';
import 'package:backendapp/screens/amenites/amenity_selector.dart';
import 'package:backendapp/register/business_selector.dart';
import 'package:backendapp/screens/graphs/review_insight.dart';
import 'package:backendapp/screens/testingchat.dart';
import 'package:backendapp/screens/graphs/profile_visit.dart';
import 'package:backendapp/widgets/operating_hours_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/provider/registrationdata_provider.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/widgets/linechart.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:backendapp/register/select_location.dart';
import 'package:backendapp/register/onboardingService.dart';
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
  runApp( 
    MultiProvider(
    providers: [
      ChangeNotifierProvider<RegistrationProvider>(
      create: (_) => RegistrationProvider() ,
    ),
    ChangeNotifierProvider<AskCommunityProvider>(
      create: (_) => AskCommunityProvider() ,
    ),
    ChangeNotifierProvider<CommentSectionProvider>(
      create: (_) => CommentSectionProvider() ,
    ),
    ChangeNotifierProvider<BusinessDataProvider>(
      create: (_) => BusinessDataProvider() ,
    ),
    ChangeNotifierProvider<ServicesProvider>(
      create: (_) => ServicesProvider(),
    ),
    ChangeNotifierProvider<InsightsProvider>(
      create: (_) => InsightsProvider(),
    ),
    ChangeNotifierProvider<HoursProvider>(
      create: (_) => HoursProvider(),
    ),
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
      // home:redirection(),
      home:CustomOnboardingService(category: "Beauty & Spas > Barbers"),
      // home:BusinessSelector(),
      // home:ReviewInsightChart(),
      // home: OnboardingService(),
    );
  } 
}

