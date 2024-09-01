// // ignore_for_file: use_build_context_synchronously
//
// import 'package:backendapp/provider/businessdata_provider.dart';
// import 'package:backendapp/register/profile_redirect.dart';
// import 'package:backendapp/register/business_selector.dart';
// import 'package:backendapp/screens/redirection.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:backendapp/utils/navigators.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // ignore: must_be_immutable
// class ProfileScreen extends StatefulWidget {
//   bool showBackButton = false;
//   bool showlogoutbutton = false;
//
//   ProfileScreen({required this.showBackButton, required this.showlogoutbutton});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String onboardBusinessMessage =
//       "Hi there! Let's get your business on board. Click here to add your business and start reaching new customers!";
//
//   @override
//   void initState() {
//     // super.initState();
//     checkBusiness();
//   }
//
//   void RemoveBusinessUid() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('businessUid');
//   }
//
//   void checkBusiness() async {
//     final user = FirebaseAuth.instance.currentUser;
//     print(user?.uid);
//     // print("profile_redirect_26");
//     if (user != null) {
//       var dataBusiness =
//           Provider.of<BusinessDataProvider>(context, listen: false);
//       dataBusiness.getBusinessData("userid", user.uid);
//       // print("getting already business");
//     } else {
//       print("elseeeeeeeeeeeeeeeeeeeee");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<BusinessDataProvider>(context);
//     // You can return a placeholder widget or loader here if needed
//     return Scaffold(
//         // backgroundColor: Color(0xFFEFF1FE),
//         backgroundColor: Colors.white,
//         // appBar: AppBar(
//         //   leading: IconButton(
//         //       onPressed: () {
//         //         // Navigator.pop(context);
//         //       },
//         //       icon: Icon(Icons.keyboard_arrow_left_rounded)),
//         //   title: Text('Profile'),
//         //   backgroundColor: tgAccentColor,
//         // ),
//
//         appBar: AppBar(
//             backgroundColor: Color(0xFFEFF1FE),
//             automaticallyImplyLeading: false,
//             leading: widget.showBackButton
//                 ? IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.keyboard_arrow_left_rounded))
//                 : null),
//         body: data.isLoading
//             ? Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 200),
//                   child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Visibility(
//                         visible: data.BusinessData != null &&
//                             data.BusinessData!.isEmpty,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               Image.asset("assets/empty.jpg",
//                                   height: 200, width: 200),
//                               SizedBox(height: 20),
//                               Text(
//                                 onboardBusinessMessage,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey[800],
//                                   // fontStyle: FontStyle.italic,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Center(
//                           child: Column(
//                         children: [
//                           if (data.BusinessData != null &&
//                               data.BusinessData!.isNotEmpty)
//                             Lottie.asset("assets/analyst.json", height: 200),
//                         ],
//                       )),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: data.BusinessData!.length,
//                           itemBuilder: (BuildContext, int) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   String businessUid =
//                                       data.BusinessData![int].businessUid;
//                                   print(businessUid);
//                                   SharedPreferences prefs =
//                                       await SharedPreferences.getInstance();
//                                   await prefs.setString(
//                                       'businessUid', businessUid);
//
//                                   // navigatorPush(
//                                   //     context,
//                                   //     Homepage(
//                                   //         businessuid:
//                                   //             data.BusinessData![int].businessUid,
//                                   //         "business_uid"));
//                                   navigatorReplace(context, ProfileRedirect());
//                                 },
//                                 child: Container(
//                                   // width: 300,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: Colors.grey),
//                                     // boxShadow: [
//                                     // BoxShadow(
//                                     //   color: Colors.grey.withOpacity(0.5),
//                                     //   spreadRadius: 2,
//                                     //   blurRadius: 5,
//                                     //   offset: Offset(0, 3), // changes position of shadow
//                                     // ),
//                                     // ],
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ListTile(
//                                         leading: Container(
//                                           width: 70,
//                                           height: double.infinity,
//                                           child: Image.network(
//                                               fit: BoxFit.fill,
//                                               data.BusinessData![int]
//                                                       .profileImageUrl ??
//                                                   "https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg"
//                                               // "https://img.jagrantv.com/webstories/ws4044/1683862688-9.jpg"
//                                               ),
//                                         ),
//                                         title: Text(data
//                                             .BusinessData![int].businessName),
//                                         subtitle: Text(
//                                             data.BusinessData![int]
//                                                 .businessDescription,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis),
//                                         trailing: Icon(
//                                             Icons.arrow_forward_ios_rounded),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                             // Text(data.BusinessData!.length.toString());
//                           }),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GestureDetector(
//                           onTap: () async {
//                             try {
//                               // print("in try");
//                               final SharedPreferences prefs =
//                                   await SharedPreferences.getInstance();
//                               final String? action =
//                                   prefs.getString('businessUid');
//                               // await prefs.setString('businessUid', "VHAClcXeT7MAuIS24zb5rIha2J22");
//                               print(action);
//                               // print("businessUid from shared preferences");
//
//                               // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                               //     builder: (context) => BusinessSelector()));
//
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return BusinessSelector();
//                               }));
//                               //         Navigator.of(context).pushReplacement(
//                               // MaterialPageRoute(builder: (context) => OnboardingService()));
//                               //
//                             } catch (e) {
//                               // print("in catch");
//                               print("Error accessing shared preferences: $e");
//                             }
//                           },
//                           child: DottedBorder(
//                               borderType: BorderType.RRect,
//                               // strokeCap: StrokeCap.round,
//                               radius: Radius.circular(12),
//                               // dashPattern: [1,3],
//                               strokeWidth: 1,
//                               color: Colors.grey,
//                               child: Container(
//                                 height: 70,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   // border: Border.all(
//                                   //   color: Colors.grey
//                                   // )
//                                 ),
//                                 // color: Colors.grey,
//                                 child: Center(
//                                   child: Icon(Icons.add_circle_sharp),
//                                 ),
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//         bottomNavigationBar: widget.showlogoutbutton
//             ? InkWell(
//                 onTap: () {
//                   FirebaseAuth.instance.signOut().then((_) {
//                     RemoveBusinessUid();
//                     // Navigate to the login page after signing out
//                     Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => redirection()));
//                   }).catchError((error) {
//                     // Handle sign-out errors if any
//                     print("Error signing out: $error");
//                   });
//                 },
//                 child: Container(
//                   height: 55,
//                   width: double.infinity,
//                   color: tgAccentColor,
//                   child: Center(
//                       child: Text(
//                     "Logout",
//                     style: TextStyle(color: Colors.white, fontSize: 17),
//                   )),
//                 ),
//               )
//             : null);
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/register/profile_redirect.dart';
import 'package:backendapp/register/business_selector.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';

// class ProfileScreen extends StatefulWidget {
//   final bool showBackButton;
//   final bool showLogoutButton;
//
//   const ProfileScreen({
//     Key? key,
//     required this.showBackButton,
//     required this.showLogoutButton,
//   }) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   static const String _onboardBusinessMessage =
//       "Hi there! Let's get your business on board. Click here to add your business and start reaching new customers!";
//
//   @override
//   void initState() {
//     super.initState();
//     _checkBusiness();
//   }
//
//   Future<void> _removeBusinessUid() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('businessUid');
//   }
//
//   void _checkBusiness() {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       Provider.of<BusinessDataProvider>(context, listen: false)
//           .getBusinessData("userid", user.uid);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: widget.showBackButton
//             ? IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         )
//             : null,
//         title: Text('Profile', style: TextStyle(color: Colors.black)),
//       ),
//       body: Consumer<BusinessDataProvider>(
//         builder: (context, data, _) {
//           if (data.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 24.0),
//                   child: _buildHeader(data),
//                 ),
//               ),
//               SliverPadding(
//                 padding: const EdgeInsets.all(16.0),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                         (context, index) => _buildBusinessCard(data.BusinessData![index], context),
//                     childCount: data.BusinessData?.length ?? 0,
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: _buildAddBusinessButton(context),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       bottomNavigationBar: widget.showLogoutButton ? _buildLogoutButton() : null,
//     );
//   }
//
//   Widget _buildHeader(BusinessDataProvider data) {
//     if (data.BusinessData != null && data.BusinessData!.isEmpty) {
//       return Column(
//         children: [
//           Image.asset("assets/empty.jpg", height: 200, width: 200),
//           SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Text(
//               _onboardBusinessMessage,
//               style: TextStyle(fontSize: 16, color: Colors.grey[800]),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       );
//     }
//     return Lottie.asset("assets/analyst.json", height: 200);
//   }
//
//   Widget _buildBusinessCard(dynamic business, BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundImage: NetworkImage(
//             business.profileImageUrl ??
//                 "https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg",
//           ),
//         ),
//         title: Text(
//           business.businessName,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         subtitle: Text(
//           business.businessDescription,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         trailing: Icon(Icons.chevron_right),
//         onTap: () => _onBusinessTap(business.businessUid, context),
//       ),
//     );
//   }
//
//   Widget _buildAddBusinessButton(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: () => _onAddBusinessTap(context),
//       icon: Icon(Icons.add),
//       label: Text('Add New Business',style: TextStyle(color: Colors.white),),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: tgAccentColor,
//         padding: EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
//
//   Widget _buildLogoutButton() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: _onLogoutTap,
//           child: Text('Logout', style: TextStyle(fontSize: 16,color: Colors.white),),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.teal,
//             padding: EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _onBusinessTap(String businessUid, BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('businessUid', businessUid);
//     navigatorReplace(context, ProfileRedirect());
//   }
//
//   void _onAddBusinessTap(BuildContext context) async {
//     Navigator.push(context, MaterialPageRoute(builder: (_) => BusinessSelector()));
//   }
//
//   void _onLogoutTap() {
//     FirebaseAuth.instance.signOut().then((_) {
//       _removeBusinessUid();
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => redirection()));
//     }).catchError((error) {
//       print("Error signing out: $error");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to log out. Please try again.')),
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/register/profile_redirect.dart';
import 'package:backendapp/register/business_selector.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';

class ProfileScreen extends StatefulWidget {
  final bool showBackButton;
  final bool showLogoutButton;

  const ProfileScreen({
    Key? key,
    required this.showBackButton,
    required this.showLogoutButton,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const String _onboardBusinessMessage =
      "Hi there! Let's get your business on board. Click here to add your business and start reaching new customers!";

  @override
  void initState() {
    super.initState();
    _checkBusiness();
  }

  Future<void> _removeBusinessUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('businessUid');
  }

  void _checkBusiness() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Provider.of<BusinessDataProvider>(context, listen: false)
          .getBusinessData("userid", user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // backgroundColor: Colors.white,
        backgroundColor: Colors.teal,
        leading: widget.showBackButton
            ? IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        )
            : null,
        title: Text('Profile', style: TextStyle(color: Colors.black,
            // fontWeight: FontWeight.bold
        )),
        actions: [
          if (widget.showLogoutButton)
            IconButton(
              icon: Icon(Icons.logout, color: Colors.red),
              onPressed: _onLogoutTap,
            ),
        ],
      ),
      body: Consumer<BusinessDataProvider>(
        builder: (context, data, _) {
          if (data.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: _buildHeader(data),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildBusinessCard(data.BusinessData![index], context),
                    childCount: data.BusinessData?.length ?? 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildAddBusinessButton(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BusinessDataProvider data) {
    if (data.BusinessData != null && data.BusinessData!.isEmpty) {
      return Column(
        children: [
          Image.asset("assets/empty.jpg", height: 200, width: 200),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              _onboardBusinessMessage,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
    return Lottie.asset("assets/analyst.json", height: 200);
  }

  Widget _buildBusinessCard(dynamic business, BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _onBusinessTap(business.businessUid, context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  business.profileImageUrl ??
                      "https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.businessName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 4),
                    Text(
                      business.businessDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddBusinessButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _onAddBusinessTap(context),
      icon: Icon(Icons.add),
      label: Text('Add New Business', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: tgAccentColor,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }

  void _onBusinessTap(String businessUid, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('businessUid', businessUid);
    navigatorReplace(context, ProfileRedirect());
  }

  void _onAddBusinessTap(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BusinessSelector()));
  }

  void _onLogoutTap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
            ),
          ],
        );
      },
    );
  }

  void _performLogout() {
    FirebaseAuth.instance.signOut().then((_) {
      _removeBusinessUid();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => redirection()));
    }).catchError((error) {
      print("Error signing out: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out. Please try again.')),
      );
    });
  }
}