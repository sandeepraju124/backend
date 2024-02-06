// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // elevation: 10,
          title:
              Container(width: 65, child: Image.asset("assets/Yelp_Logo.png")),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.notification_important_outlined),
            )
          ],
        ),
        body: SingleChildScrollView(
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
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        child: Text("Start with a Headline", style: TextStyle(fontSize: 16,)),
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
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
