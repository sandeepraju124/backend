// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/screens/askcommunity.dart';
import 'package:backendapp/screens/testing.dart';
import 'package:backendapp/screens/testing2.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
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
      var dataAsk = Provider.of<AskCommunityProvider>(context, listen: false);
      dataAsk.fetchAskCommunityData("NEX1O16051534921137");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // elevation: 10,
          title:
              Container(width: 65, child: Image.asset("assets/Yelp_Logo.png")),
          actions: [
            GestureDetector(
              onTap: ()async{
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('businessUid');
                FirebaseAuth.instance.signOut();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.notification_important_outlined),
              ),
            )
          ],
        ),
        body: data.isLoading ? CircularProgressIndicator() :
        SingleChildScrollView(
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
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
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
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey)),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                      RetangularBorderBox("POST"),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    navigatorPush(
                        context,
                        DisplaySelected()
                        // AskForCommunityWidget(
                        //   uid: '',
                        //   Questionid: "",
                        // )
                        );
                  },
                  child: Text("click")),
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
                        GestureDetector(
                          onTap: () async{
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                          final String? action = prefs.getString('businessUid');
                          // await prefs.setString('businessUid', "VHAClcXeT7MAuIS24zb5rIha2J22");
                          print(action);
                          },
                          child: Text("enough space")),
                        // Text(data.BusinessData![0].businessDescription)

            ],
          ),
        ));
  }
}
