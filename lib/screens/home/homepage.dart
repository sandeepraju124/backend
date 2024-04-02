// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/screens/home/firstpage.dart';
import 'package:backendapp/screens/home/Community.dart';
import 'package:backendapp/screens/home/s1.dart';
import 'package:backendapp/screens/home/secondpage.dart';
import 'package:backendapp/screens/home/business_info_hub.dart';
import 'package:backendapp/widgets/Businessinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
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
    
    // var dataBusiness = Provider.of<BusinessDataProvider>(context, listen: false);
    //   dataBusiness.getBusinessData("business_uid", widget.businessuid);
    // final user = FirebaseAuth.instance.currentUser;
    // print(user);
    // print("current user");

    // super.initState();
  }

  void getBusinessData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? businessUid = prefs.getString('businessUid');
    var dataBusiness = Provider.of<BusinessDataProvider>(context, listen: false);
    dataBusiness.getBusinessData("business_uid",businessUid!);
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 66,
        child: BottomNavigationBar(
          // elevation: 0,
          
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            print(value);
            });
          },
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          // backgroundColor: Colors.grey,
          items: [
          BottomNavigationBarItem(icon:  SvgPicture.asset(_selectedIndex== 0 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
          BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 1 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
          BottomNavigationBarItem(icon: _selectedIndex ==2 ? SvgPicture.asset("assets/svg/chart-pie-svgrepo-filled.svg",height: 23):SvgPicture.asset("assets/svg/chart-pie-svgrepo-out.svg",height: 26), label: ""),
          BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 3 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
          BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 4 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
        ]),
      ),
    );
  }
}
