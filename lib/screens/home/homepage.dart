// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:backendapp/screens/home/firstpage.dart';
import 'package:backendapp/screens/home/fourthpage.dart';
import 'package:backendapp/screens/home/s1.dart';
import 'package:backendapp/screens/home/secondpage.dart';
import 'package:backendapp/screens/home/thirdpage.dart';
import 'package:backendapp/widgets/Businessinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Firstpage(),
    Insights(),
    thirdpage(),
    PaymentGateway(),
    // OperatingHoursScreen(),
    // BasicInfoForm(),
    PaymentPage()

  ];


  @override
  Widget build(BuildContext context) {
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
