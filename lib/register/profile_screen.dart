// ignore_for_file: use_build_context_synchronously

import 'package:backendapp/models/businessdata_models.dart';
import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/register/profile_redirect.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // super.initState();
    checkBusiness();
  }

  void checkBusiness() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user?.uid);
    print("profile_redirect_26");
    if (user != null) {
      var dataBusiness =
          Provider.of<BusinessDataProvider>(context, listen: false);
      dataBusiness.getBusinessData("userid", user.uid);
      // User exists, redirect to home screen
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => ProfileScreen()),
      // );
    } else {
      print("elseeeeeeeeeeeeeeeeeeeee");
      // User does not exist, redirect to another page
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Homepage()),
      // );
    }
  }


  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    // You can return a placeholder widget or loader here if needed
    return Scaffold(
        body: data.isLoading
            ? CircularProgressIndicator()
            : Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.BusinessData!.length,
                      itemBuilder: (BuildContext, int) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              String businessUid = data.BusinessData![int].businessUid;
                              print(businessUid);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('businessUid', businessUid);

                              // navigatorPush(
                              //     context,
                              //     Homepage(
                              //         businessuid:
                              //             data.BusinessData![int].businessUid,
                              //         "business_uid"));
                              navigatorReplace(context,ProfileRedirect() );
                            },
                            child: Container(
                              // width: 300,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                                // boxShadow: [
                                // BoxShadow(
                                //   color: Colors.grey.withOpacity(0.5),
                                //   spreadRadius: 2,
                                //   blurRadius: 5,
                                //   offset: Offset(0, 3), // changes position of shadow
                                // ),
                                // ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      width: 70,
                                      height: double.infinity,
                                      child: Image.network(
                                          fit: BoxFit.fill,
                                          data.BusinessData![int]
                                              .profileImageUrl
                                          // "https://img.jagrantv.com/webstories/ws4044/1683862688-9.jpg"
                                          ),
                                    ),
                                    title: Text(
                                        data.BusinessData![int].businessName),
                                    subtitle: Text(
                                        data.BusinessData![int]
                                            .businessDescription,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    trailing:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        // Text(data.BusinessData!.length.toString());
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("in try");
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final String? action = prefs.getString('businessUid');
                          // await prefs.setString('businessUid', "VHAClcXeT7MAuIS24zb5rIha2J22");
                          print(action);
                          print("businessUid from shared preferences");
                        } catch (e) {
                          print("in catch");
                          print("Error accessing shared preferences: $e");
                        }
                      },
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          // strokeCap: StrokeCap.round,
                          radius: Radius.circular(12),
                          // dashPattern: [1,3],
                          strokeWidth: 1,
                          color: Colors.grey,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: Colors.grey
                              // )
                            ),
                            // color: Colors.grey,
                            child: Center(
                              child: Icon(Icons.add_circle_sharp),
                            ),
                          )),
                    ),
                  ),
                ],
              ));
  }
}
