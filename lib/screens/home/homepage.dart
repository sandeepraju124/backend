// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/provider/house_provider.dart';
import 'package:backendapp/provider/insights_provider.dart';
import 'package:backendapp/screens/home/firstpage.dart';
import 'package:backendapp/screens/home/Community.dart';
import 'package:backendapp/screens/home/s1.dart';
import 'package:backendapp/screens/home/insights_page.dart';
import 'package:backendapp/screens/home/business_info_hub.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  final int initialIndex;
  Homepage({this.initialIndex = 0});
  // String businessuid;

  // Homepage(String s, {required this.businessuid});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Firstpage(),
    Insights(),
    BusinessInfoHub(),
    Community(),
    // OperatingHoursScreen(),
    // BasicInfoForm(),
    PaymentPage()
  ];

  @override
  void initState() {
    getBusinessData();
    _selectedIndex = widget.initialIndex;
    // Provider.of<CommentSectionProvider>(context, listen: false)
    //     .commentSectionProvider("PIZFOO4357128905678");

    // var dataBusiness = Provider.of<BusinessDataProvider>(context, listen: false);
    //   dataBusiness.getBusinessData("business_uid", widget.businessuid);
    // final user = FirebaseAuth.instance.currentUser;
    // print(user);
    // print("current user");

    // super.initState();
  }

  void getBusinessData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? businessUid = prefs.getString('businessUid');
    // print("Business_uid = $businessUid");
    var dataBusiness =
        Provider.of<BusinessDataProvider>(context, listen: false);
    await dataBusiness
        .getBusinessData("business_uid", businessUid!)
        .then((onValue) {
      print(onValue);
      if (onValue == true) {
        if (dataBusiness.BusinessData![0].subCategory == "Fullhouse") {
          log("this is full house");
          var houseData = Provider.of<HouseProvider>(context, listen: false)
              .fetchHouseData(businessUid);
        }
      } else {
        print("Failed to fetch house details Data");
      }
    });
    // await dataBusiness.getBusinessData("business_uid", businessUid!);
    var commentsData =
        Provider.of<CommentSectionProvider>(context, listen: false)
            .commentSectionProvider(businessUid);
    var askCommData = Provider.of<AskCommunityProvider>(context, listen: false)
        .fetchAskCommunityData(businessUid);
    var servicesData = Provider.of<ServicesProvider>(context, listen: false)
        .getMongoBusinessData(businessUid);
    var insightData = Provider.of<InsightsProvider>(context, listen: false)
        .fetchReviewData(businessUid);
    var insightDataProvileVisit =
        Provider.of<InsightsProvider>(context, listen: false)
            .fetchprofileVisitData(businessUid);
    print(DateTime.now().add(Duration(days: 10)).toIso8601String());
    print(".......................................");
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 66,
        child:
            // BottomNavigationBar(
            //   // elevation: 0,

            //   currentIndex: _selectedIndex,
            //   onTap: (value) {f
            //     setState(() {
            //       _selectedIndex = value;
            //     print(value);
            //     });
            //   },
            //   showUnselectedLabels: false,
            //   showSelectedLabels: false,
            //   type: BottomNavigationBarType.fixed,
            //   // backgroundColor: Colors.grey,
            //   items: [
            //   // BottomNavigationBarItem(icon:  SvgPicture.asset(_selectedIndex== 0 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
            //   // BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 1 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
            //   // BottomNavigationBarItem(icon: _selectedIndex ==2 ? SvgPicture.asset("assets/svg/chart-pie-svgrepo-filled.svg",height: 23):SvgPicture.asset("assets/svg/chart-pie-svgrepo-out.svg",height: 26), label: ""),
            //   // BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 3 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
            //   // BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 4 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),

            //   BottomNavigationBarItem(icon: Icon(Icons.home_outlined, ), label: ""),
            // ]
            // ),
            BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
              print(value);
            });
          },
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 2
                    ? Icons.home_work_outlined
                    : Icons.home_work_rounded,
                size: 26,
                // color: Colors.black,
                color: secondaryColor40LightTheme,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? Icons.show_chart_rounded
                  : Icons.bar_chart_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 2
                    ? Icons.add_business_rounded
                    : Icons.add_business_outlined,
                size: 26,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 3
                    ? Icons.forum_rounded
                    : Icons.forum_outlined,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 4
                    ? Icons.account_circle
                    : Icons.account_circle_outlined,
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
