// // // // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// // // import 'dart:developer';

// // // import 'package:backendapp/provider/askcommunityprovider.dart';
// // // import 'package:backendapp/provider/businessdata_provider.dart';
// // // import 'package:backendapp/provider/businessmongo_provider.dart';
// // // import 'package:backendapp/provider/commentprovider.dart';
// // // import 'package:backendapp/provider/house_provider.dart';
// // // import 'package:backendapp/provider/insights_provider.dart';
// // // import 'package:backendapp/screens/home/firstpage.dart';
// // // import 'package:backendapp/screens/home/Community.dart';
// // // import 'package:backendapp/screens/home/PaymentPage.dart';
// // // import 'package:backendapp/screens/home/insights_page.dart';
// // // import 'package:backendapp/screens/home/business_info_hub.dart';
// // // import 'package:backendapp/utils/constants.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';

// // // class Homepage extends StatefulWidget {
// // //   final int initialIndex;
// // //   Homepage({this.initialIndex = 0});
// // //   // String businessuid;

// // //   // Homepage(String s, {required this.businessuid});

// // //   @override
// // //   State<Homepage> createState() => _HomepageState();
// // // }

// // // class _HomepageState extends State<Homepage> {
// // //   int _selectedIndex = 0;

// // //   final List<Widget> _pages = [
// // //     Firstpage(),
// // //     Insights(),
// // //     BusinessInfoHub(),
// // //     Community(),
// // //     // OperatingHoursScreen(),
// // //     // BasicInfoForm(),
// // //     PaymentPage()
// // //   ];

// // //   @override
// // //   void initState() {
// // //     getBusinessData();
// // //     _selectedIndex = widget.initialIndex;
// // //     // Provider.of<CommentSectionProvider>(context, listen: false)
// // //     //     .commentSectionProvider("PIZFOO4357128905678");

// // //     // var dataBusiness = Provider.of<BusinessDataProvider>(context, listen: false);
// // //     //   dataBusiness.getBusinessData("business_uid", widget.businessuid);
// // //     // final user = FirebaseAuth.instance.currentUser;
// // //     // print(user);
// // //     // print("current user");

// // //     // super.initState();
// // //   }

// // //   void getBusinessData() async {
// // //     SharedPreferences prefs = await SharedPreferences.getInstance();
// // //     String? businessUid = prefs.getString('businessUid');
// // //     // print("Business_uid = $businessUid");
// // //     var dataBusiness =
// // //         Provider.of<BusinessDataProvider>(context, listen: false);
// // //     await dataBusiness
// // //         .getBusinessData("business_uid", businessUid!)
// // //         .then((onValue) {
// // //       print(onValue);
// // //       if (onValue == true) {
// // //         if (dataBusiness.BusinessData![0].subCategory == "Fullhouse") {
// // //           log("this is full house");
// // //           var houseData = Provider.of<HouseProvider>(context, listen: false)
// // //               .fetchHouseData(businessUid);
// // //         }
// // //       } else {
// // //         print("Failed to fetch house details Data");
// // //       }
// // //     });
// // //     // await dataBusiness.getBusinessData("business_uid", businessUid!);
// // //     var commentsData =
// // //         Provider.of<CommentSectionProvider>(context, listen: false)
// // //             .commentSectionProvider(businessUid);
// // //     var askCommData = Provider.of<AskCommunityProvider>(context, listen: false)
// // //         .fetchAskCommunityData(businessUid);
// // //     var servicesData = Provider.of<ServicesProvider>(context, listen: false)
// // //         .getMongoBusinessData(businessUid);
// // //     var insightData = Provider.of<InsightsProvider>(context, listen: false)
// // //         .fetchReviewData(businessUid);
// // //     var insightDataProvileVisit =
// // //         Provider.of<InsightsProvider>(context, listen: false)
// // //             .fetchprofileVisitData(businessUid);
// // //     print(DateTime.now().add(Duration(days: 10)).toIso8601String());
// // //     print(".......................................");
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     var data = Provider.of<BusinessDataProvider>(context);
// // //     return Scaffold(
// // //       backgroundColor: Colors.cyan,
// // //       body: _pages[_selectedIndex],
// // //       bottomNavigationBar: SizedBox(
// // //         height: 66,
// // //         child:
// // //             // BottomNavigationBar(
// // //             //   // elevation: 0,

// // //             //   currentIndex: _selectedIndex,
// // //             //   onTap: (value) {f
// // //             //     setState(() {
// // //             //       _selectedIndex = value;
// // //             //     print(value);
// // //             //     });
// // //             //   },
// // //             //   showUnselectedLabels: false,
// // //             //   showSelectedLabels: false,
// // //             //   type: BottomNavigationBarType.fixed,
// // //             //   // backgroundColor: Colors.grey,
// // //             //   items: [
// // //             //   // BottomNavigationBarItem(icon:  SvgPicture.asset(_selectedIndex== 0 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
// // //             //   // BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 1 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
// // //             //   // BottomNavigationBarItem(icon: _selectedIndex ==2 ? SvgPicture.asset("assets/svg/chart-pie-svgrepo-filled.svg",height: 23):SvgPicture.asset("assets/svg/chart-pie-svgrepo-out.svg",height: 26), label: ""),
// // //             //   // BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 3 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),
// // //             //   // BottomNavigationBarItem(icon: SvgPicture.asset(_selectedIndex== 4 ? "assets/svg/four-squares-icon.svg": "assets/svg/four-squares-line-icon.svg",height: 23), label: ""),

// // //             //   BottomNavigationBarItem(icon: Icon(Icons.home_outlined, ), label: ""),
// // //             // ]
// // //             // ),
// // //             BottomNavigationBar(
// // //           onTap: (value) {
// // //             setState(() {
// // //               _selectedIndex = value;
// // //               print(value);
// // //             });
// // //           },
// // //           showUnselectedLabels: false,
// // //           showSelectedLabels: false,
// // //           type: BottomNavigationBarType.fixed,
// // //           items: [
// // //             BottomNavigationBarItem(
// // //               icon: Icon(
// // //                 _selectedIndex == 2
// // //                     ? Icons.home_work_outlined
// // //                     : Icons.home_work_rounded,
// // //                 size: 26,
// // //                 // color: Colors.black,
// // //                 color: secondaryColor40LightTheme,
// // //               ),
// // //               label: "",
// // //             ),
// // //             BottomNavigationBarItem(
// // //               icon: Icon(_selectedIndex == 1
// // //                   ? Icons.show_chart_rounded
// // //                   : Icons.bar_chart_rounded),
// // //               label: "",
// // //             ),
// // //             BottomNavigationBarItem(
// // //               icon: Icon(
// // //                 _selectedIndex == 2
// // //                     ? Icons.add_business_rounded
// // //                     : Icons.add_business_outlined,
// // //                 size: 26,
// // //               ),
// // //               label: "",
// // //             ),
// // //             BottomNavigationBarItem(
// // //               icon: Icon(
// // //                 _selectedIndex == 3
// // //                     ? Icons.forum_rounded
// // //                     : Icons.forum_outlined,
// // //               ),
// // //               label: "",
// // //             ),
// // //             BottomNavigationBarItem(
// // //               icon: Icon(
// // //                 _selectedIndex == 4
// // //                     ? Icons.account_circle
// // //                     : Icons.account_circle_outlined,
// // //               ),
// // //               label: "",
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'dart:developer';

// // // import 'package:backendapp/provider/askcommunityprovider.dart';
// // // import 'package:backendapp/provider/businessdata_provider.dart';
// // // import 'package:backendapp/provider/businessmongo_provider.dart';
// // // import 'package:backendapp/provider/commentprovider.dart';
// // // import 'package:backendapp/provider/house_provider.dart';
// // // import 'package:backendapp/provider/insights_provider.dart';
// // // import 'package:backendapp/screens/home/firstpage.dart';
// // // import 'package:backendapp/screens/home/Community.dart';
// // // import 'package:backendapp/screens/home/insights_page.dart';
// // // import 'package:backendapp/screens/home/business_info_hub.dart';
// // // import 'package:backendapp/screens/home/PaymentPage.dart';
// // // import 'package:backendapp/utils/constants.dart';

// // // class Homepage extends StatefulWidget {
// // //   final int initialIndex;

// // //   const Homepage({Key? key, this.initialIndex = 0}) : super(key: key);

// // //   @override
// // //   State<Homepage> createState() => _HomepageState();
// // // }

// // // class _HomepageState extends State<Homepage> {
// // //   late int _selectedIndex;

// // //   final List<Widget> _pages = [
// // //     const Firstpage(),
// // //     const Insights(),
// // //     BusinessInfoHub(),
// // //     const Community(),
// // //     PaymentPage(),
// // //   ];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _selectedIndex = widget.initialIndex;
// // //     getBusinessData();
// // //   }

// // //   Future<void> getBusinessData() async {
// // //     SharedPreferences prefs = await SharedPreferences.getInstance();
// // //     String? businessUid = prefs.getString('businessUid');
// // //     if (businessUid == null) return;

// // //     var dataBusiness =
// // //         Provider.of<BusinessDataProvider>(context, listen: false);
// // //     bool success =
// // //         await dataBusiness.getBusinessData("business_uid", businessUid);

// // //     if (success) {
// // //       if (dataBusiness.BusinessData?[0].subCategory == "Fullhouse") {
// // //         log("This is full house");
// // //         await Provider.of<HouseProvider>(context, listen: false)
// // //             .fetchHouseData(businessUid);
// // //       }
// // //     } else {
// // //       log("Failed to fetch house details Data");
// // //     }

// // //     // Fetch other data
// // //     await Provider.of<CommentSectionProvider>(context, listen: false)
// // //         .commentSectionProvider(businessUid);
// // //     await Provider.of<AskCommunityProvider>(context, listen: false)
// // //         .fetchAskCommunityData(businessUid);
// // //     await Provider.of<ServicesProvider>(context, listen: false)
// // //         .getMongoBusinessData(businessUid);
// // //     await Provider.of<InsightsProvider>(context, listen: false)
// // //         .fetchReviewData(businessUid);
// // //     await Provider.of<InsightsProvider>(context, listen: false)
// // //         .fetchprofileVisitData(businessUid);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: IndexedStack(
// // //         index: _selectedIndex,
// // //         children: _pages,
// // //       ),
// // //       bottomNavigationBar: NavigationBar(
// // //         onDestinationSelected: (int index) {
// // //           setState(() {
// // //             _selectedIndex = index;
// // //           });
// // //         },
// // //         selectedIndex: _selectedIndex,
// // //         destinations: const <NavigationDestination>[
// // //           NavigationDestination(
// // //             icon: Icon(Icons.home_outlined),
// // //             selectedIcon: Icon(Icons.home),
// // //             label: 'Home',
// // //           ),
// // //           NavigationDestination(
// // //             icon: Icon(Icons.insights_outlined),
// // //             selectedIcon: Icon(Icons.insights),
// // //             label: 'Insights',
// // //           ),
// // //           NavigationDestination(
// // //             icon: Icon(Icons.business_center_outlined),
// // //             selectedIcon: Icon(Icons.business_center),
// // //             label: 'Business',
// // //           ),
// // //           NavigationDestination(
// // //             icon: Icon(Icons.forum_outlined),
// // //             selectedIcon: Icon(Icons.forum),
// // //             label: 'Community',
// // //           ),
// // //           NavigationDestination(
// // //             icon: Icon(Icons.account_circle_outlined),
// // //             selectedIcon: Icon(Icons.account_circle),
// // //             label: 'Account',
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:developer';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // // Import statements remain the same
// // import 'package:backendapp/provider/askcommunityprovider.dart';
// // import 'package:backendapp/provider/businessdata_provider.dart';
// // import 'package:backendapp/provider/businessmongo_provider.dart';
// // import 'package:backendapp/provider/commentprovider.dart';
// // import 'package:backendapp/provider/house_provider.dart';
// // import 'package:backendapp/provider/insights_provider.dart';
// // import 'package:backendapp/screens/home/firstpage.dart';
// // import 'package:backendapp/screens/home/Community.dart';
// // import 'package:backendapp/screens/home/PaymentPage.dart';
// // import 'package:backendapp/screens/home/insights_page.dart';
// // import 'package:backendapp/screens/home/business_info_hub.dart';

// // import '../../provider/chat_provider.dart';
// // import '../chat.dart';

// // class BottomNav extends StatefulWidget {
// //   final int initialIndex;
// //   BottomNav({this.initialIndex = 0});

// //   @override
// //   State<BottomNav> createState() => _BottomNavState();
// // }

// // class _BottomNavState extends State<BottomNav> {
// //   int _selectedIndex = 0;

// //   final List<Widget> _pages = [
// //     HomePage(),
// //     Insights(),
// //     ChatListScreen(
// //       BusinessID: 'BIZFOORESW1nD9SmSb0',
// //     ),
// //     BusinessInfoHub(),
// //     Community(),
// //     PaymentPage()
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _selectedIndex = widget.initialIndex;
// //     getBusinessData();
// //   }

// //   void getBusinessData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? businessUid = prefs.getString('businessUid');

// //     if (businessUid != null) {
// //       var dataBusiness =
// //           Provider.of<BusinessDataProvider>(context, listen: false);
// //       var result =
// //           await dataBusiness.getBusinessData("business_uid", businessUid);

// //       if (result == true) {
// //         if (dataBusiness.BusinessData?[0].subCategory == "Fullhouse") {
// //           log("This is full house");
// //           await Provider.of<HouseProvider>(context, listen: false)
// //               .fetchHouseData(businessUid);
// //         }
// //       } else {
// //         print("Failed to fetch house details Data");
// //       }

// //       // Fetch other data
// //       await Future.wait([
// //         Provider.of<CommentSectionProvider>(context, listen: false)
// //             .getComments(businessUid),
// //         Provider.of<AskCommunityProvider>(context, listen: false)
// //             .fetchAskCommunityData(businessUid),
// //         Provider.of<ServicesProvider>(context, listen: false)
// //             .getMongoBusinessData(businessUid),
// //         Provider.of<InsightsProvider>(context, listen: false)
// //             .fetchReviewData(businessUid),
// //         Provider.of<InsightsProvider>(context, listen: false)
// //             .fetchprofileVisitData(businessUid),
// //       ]);
// //       // var chat = Provider.of<ChatProvider>(context, listen: false).fetchConversations(businessUid);
// //       var chat = Provider.of<ChatProvider>(context, listen: false)
// //           .fetchConversations("BIZPLUaYVJg3dqD9");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: IndexedStack(
// //         index: _selectedIndex,
// //         children: _pages,
// //       ),
// //       bottomNavigationBar: Container(
// //         decoration: BoxDecoration(
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.1),
// //               blurRadius: 10,
// //               offset: Offset(0, -5),
// //             ),
// //           ],
// //         ),
// //         child: BottomNavigationBar(
// //           currentIndex: _selectedIndex,
// //           onTap: (index) => setState(() => _selectedIndex = index),
// //           type: BottomNavigationBarType.fixed,
// //           backgroundColor: Colors.white,
// //           selectedItemColor: Colors.black87,
// //           unselectedItemColor: Colors.grey,
// //           selectedFontSize: 12,
// //           unselectedFontSize: 12,
// //           elevation: 0,
// //           items: [
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.home_rounded),
// //               label: 'Home',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.insights_rounded),
// //               label: 'Insights',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.chat_bubble_outline),
// //               label: 'Chat',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.business_center_rounded),
// //               label: 'Business',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.forum_rounded),
// //               label: 'Community',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.account_circle_rounded),
// //               label: 'Account',
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:backendapp/provider/askcommunityprovider.dart';
// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:backendapp/provider/commentprovider.dart';
// import 'package:backendapp/provider/house_provider.dart';
// import 'package:backendapp/screens/home/firstpage.dart';
// import 'package:backendapp/screens/home/Community.dart';
// import 'package:backendapp/screens/home/PaymentPage.dart';
// import 'package:backendapp/screens/home/business_info_hub.dart';

// import '../../provider/chat_provider.dart';
// import '../chat.dart';

// class BottomNav extends StatefulWidget {
//   final int initialIndex;
//   BottomNav({this.initialIndex = 0});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     HomePage(),
//     ChatListScreen(BusinessID: 'BIZFOORESW1nD9SmSb0'),
//     BusinessInfoHub(),
//     Community(),
//     PaymentPage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.initialIndex;
//     getBusinessData();
//   }

//   void getBusinessData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? businessUid = prefs.getString('businessUid');

//     if (businessUid != null) {
//       var dataBusiness =
//           Provider.of<BusinessDataProvider>(context, listen: false);
//       var result =
//           await dataBusiness.getBusinessData("business_uid", businessUid);

//       if (result == true) {
//         if (dataBusiness.BusinessData?[0].subCategory == "Fullhouse") {
//           await Provider.of<HouseProvider>(context, listen: false)
//               .fetchHouseData(businessUid);
//         }
//       } else {
//         print("Failed to fetch house details Data");
//       }

//       await Future.wait([
//         Provider.of<CommentSectionProvider>(context, listen: false)
//             .getComments(businessUid),
//         Provider.of<AskCommunityProvider>(context, listen: false)
//             .fetchAskCommunityData(businessUid),
//         Provider.of<ServicesProvider>(context, listen: false)
//             .getMongoBusinessData(businessUid),
//       ]);

//       var chat = Provider.of<ChatProvider>(context, listen: false)
//           .fetchConversations("BIZPLUaYVJg3dqD9");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) => setState(() => _selectedIndex = index),
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Business',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.forum),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Account',
//           ),
//         ],
//         selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//         unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
//       ),
//     );
//   }
// }

import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/provider/house_provider.dart';
import 'package:backendapp/screens/home/firstpage.dart';
import 'package:backendapp/screens/home/Community.dart';
import 'package:backendapp/screens/home/PaymentPage.dart';
import 'package:backendapp/screens/home/business_info_hub.dart';

import '../../provider/chat_provider.dart';
import '../chat.dart';

class BottomNav extends StatefulWidget {
  final int initialIndex;
  BottomNav({this.initialIndex = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ChatListScreen(BusinessID: 'BIZFOORESW1nD9SmSb0'),
    BusinessInfoHub(),
    Community(),
    PaymentPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    getBusinessData();
  }

  void getBusinessData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? businessUid = prefs.getString('businessUid');

    if (businessUid != null) {
      var dataBusiness =
          Provider.of<BusinessDataProvider>(context, listen: false);
      var result =
          await dataBusiness.getBusinessData("business_uid", businessUid);

      if (result == true) {
        if (dataBusiness.BusinessData?[0].subCategory == "Fullhouse") {
          await Provider.of<HouseProvider>(context, listen: false)
              .fetchHouseData(businessUid);
        }
      } else {
        print("Failed to fetch house details Data");
      }

      await Future.wait([
        Provider.of<CommentSectionProvider>(context, listen: false)
            .getComments(businessUid),
        Provider.of<AskCommunityProvider>(context, listen: false)
            .fetchAskCommunityData(businessUid),
        Provider.of<ServicesProvider>(context, listen: false)
            .getMongoBusinessData(businessUid),
      ]);

      var chat = Provider.of<ChatProvider>(context, listen: false)
          .fetchConversations("BIZPLUaYVJg3dqD9");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.indigo[900],
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forum),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              onPressed: () => setState(() => _selectedIndex = 2),
              backgroundColor: tgPrimaryColor,
              child: Icon(Icons.business, size: 30),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }
}
