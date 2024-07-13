// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/screens/progressbar.dart';
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // var dataAsk = Provider.of<AskCommunityProvider>(context, listen: false);
      // dataAsk.fetchAskCommunityData("NEX1O16051534921137");
    });
    super.initState();
  }

  void RemoveBusinessUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('businessUid');
  }

  // double getProgress() {
  //   int totalTasks = 3; // Example: operating hours, amenities, profile information
  //   int completedTasks = 0;

  //   if (_businessData.operatingHours != null) completedTasks++;
  //   if (_businessData.amenities != null) completedTasks++;
  //   if (_businessData.profileInformation != null) completedTasks++;

  //   return completedTasks / totalTasks;
  // }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    var data2 = Provider.of<ServicesProvider>(context);

    double getProgress() {
      int totalTasks =
          7; // Example: operating hours, amenities, profile information
      int completedTasks = 0;

      // Safely check if the properties are not null before accessing them
      if (data.BusinessData != null) {
        if (data.BusinessData!.isNotEmpty) {
          if (data.BusinessData![0].contactInformation?.isNotEmpty ?? false)
            completedTasks++;
          if (data.BusinessData![0].businessEmail?.isNotEmpty ?? false)
            completedTasks++;
          if (data.BusinessData![0].address?.isNotEmpty ?? false)
            completedTasks++;
          if (data.BusinessData![0].businessDescription?.isNotEmpty ?? false)
            completedTasks++;
          print("...................");
          print("phone number ${data.BusinessData![0].contactInformation}");
          print("email ${data.BusinessData![0].businessEmail}");
          print("address ${data.BusinessData![0].address}");
          print("business desp ${data.BusinessData![0].businessDescription}");
          print("...................");
        }
      }

      if (data2.BusinessData != null) {
        if (data2.BusinessData!.amenities != null) completedTasks++;
        if (data2.BusinessData!.operatingHours != null) completedTasks++;
        if (data2.BusinessData!.images != null) completedTasks++;

        print("...................");
        print("amenities ${data2.BusinessData!.amenities}");
        print("operatingHours ${data2.BusinessData!.operatingHours}");
        print("operatingHours ${data2.BusinessData!.operatingHours != null}");
        print("images ${data2.BusinessData!.images}");
        print("...................");
        print("completedTasks $completedTasks");
        print("totalTasks $totalTasks");
        print("completedTasks / totalTasks ${completedTasks / totalTasks}");
      }

      return completedTasks / totalTasks;
    }

    return Scaffold(
        appBar: AppBar(
          // leading: Center(child: Text("NearMe")),
          automaticallyImplyLeading: false,
          // elevation: 10,
          title: Container(
              width: 95,
              child: Image.asset(
                "assets/nearme2.png",
              )),
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut().then((_) {
                  RemoveBusinessUid();
                  // Navigate to the login page after signing out
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => redirection()));
                }).catchError((error) {
                  // Handle sign-out errors if any
                  print("Error signing out: $error");
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.notification_important_outlined),
              ),
            )
          ],
        ),
        body: data.isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: tgPrimaryColor,
              ))
            : SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      height: 2,
                    ),
                    Container(
                      width: double.infinity,
                      height: 75,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            // color: Colors.blue,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "3,567",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "followers",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ]),
                          ),
                          Container(
                            width: 100,
                            // color: Colors.lime,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("123",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                Text("Profile Views",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // color: Colors.grey,
                    ),
                    Divider(
                      thickness: 1,
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "View all insights...",
                        style: TextStyle(color: tgDarkPrimaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      child: Container(
                        // padding: EdgeInsets.all(20.0),
                        height: 160,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          // borderRadius: BorderRadius.circular(10.0),
                          // color:
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Text("Start with a Headline",
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: Colors.grey),
                              //   // borderRadius: BorderRadius.circular(5.0),
                              // ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: 'Add a discription',
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  showSnackBar(context,
                                      "feature not available yet, stay tuned");
                                },
                                child: RetangularBorderBox("POST")),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // GestureDetector(onTap: () {}, child: Text("click")),

                    //   SliverToBoxAdapter(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 16),
                    //     child: Container(
                    //         height: 600,
                    //         color: secondaryColor5LightTheme,
                    //         child: AskForCommunityWidget(
                    //           uid: '',
                    //           Questionid: "",
                    //         )),
                    //   ),
                    // ),
                    // AskForCommunityWidget(
                    //           uid: '',
                    //           Questionid: "",
                    //         ),

                    Center(
                      // child: EnhancedHalfCircleProgressBar(0.3),
                      child: EnhancedHalfCircleProgressBar(getProgress()),
                    ),

                    GestureDetector(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final String? action = prefs.getString('businessUid');
                          // await prefs.setString('businessUid', "VHAClcXeT7MAuIS24zb5rIha2J22");
                          print("businessUid: $action");
                          showSnackBar(context, action!);
                        },
                        child: Text("Print BusinessUid")),
                    // Text(data.BusinessData![0].businessDescription)
                  ],
                ),
              ));
  }
}
