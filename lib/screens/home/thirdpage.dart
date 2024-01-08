// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/widgets/AmenitiesandMore.dart';
import 'package:backendapp/widgets/Businessinfo.dart';
import 'package:backendapp/widgets/HoursofOperations.dart';
import 'package:flutter/material.dart';

class thirdpage extends StatefulWidget {
  @override
  State<thirdpage> createState() => _thirdpageState();
}

class _thirdpageState extends State<thirdpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Stack(clipBehavior: Clip.none, children: [
            Container( 
                height: 140,
                width: double.infinity,
                color: Colors.blue,
                child: Image(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1501862700950-18382cd41497?auto=format&fit=crop&q=80&w=2019&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                )),
            Positioned(
              bottom: -70,
              child: Container(
                height: 100,
                width: 100,
                // color: Colors.teal,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=1887&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      fit: BoxFit
                          .cover, // Use BoxFit.cover to make the image cover the entire circular container
                    ),
                  ),
                ),
              ),
            )
          ]),
          // SizedBox(
          //   height: 80,
          // ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // empty container just to hide backside of profile image
                Expanded(
                    flex: 25,
                    child: Container(
                      height: 40,
                      // color: Colors.lightGreenAccent,
                    )),
                Expanded(
                    flex: 75,
                    child: Container(
                      height: 40,
                      // color: Colors.deepPurpleAccent,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              // width: 100,
                              height: 40,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors
                                      .grey, // You can customize the border color
                                  // width: 2.0, // You can customize the border width
                                ),
                              ),

                              child: Text(
                                'See reviews',
                                style: TextStyle(color: Colors.teal),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(10),
                              // width: 100,
                              height: 40,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors
                                      .grey, // You can customize the border color
                                  // width: 2.0, // You can customize the border width
                                ),
                              ),

                              child: Text(
                                'Add photos',
                                style: TextStyle(color: Colors.teal),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              // width: 100,
                              height: 40,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                color: Colors.white, 
                                border: Border.all(
                                  color: Colors
                                      .grey, // You can customize the border color
                                  // width: 2.0, // You can customize the border width
                                ),
                              ),

                              child: Text(
                                'View ',
                                style: TextStyle(color: Colors.teal),
                              ),
                            )
                            // Container(
                            //   color: Colors.purpleAccent,
                            //   height: 40,
                            //   width: 70,
                            // )
                          ]),
                    ))
                // Container(color: Colors.deepPurpleAccent,height: 40,width: 40,),
                // Container(color: Colors.pink,height: 40,width: 40,),
                // Container(color: Colors.purpleAccent,height: 40,width: 40,)
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Sandeep Raju"),

          Text("***********"),
          Row(
              children: [
                // star 1
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.star,
                      color:  tgDarkPrimaryColor ,
                      size: 24),
                ),
                SizedBox(
                  width: 4,
                ),
                // star 2
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                  padding: EdgeInsets.all(5),
                  child: Icon( Icons.star,
                      color: tgDarkPrimaryColor ,
                      size: 24),
                ),
                SizedBox(
                  width: 4,
                ),
                // star 3
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                  padding: EdgeInsets.all(5),
                  child: Icon( Icons.star,
                      color:  tgDarkPrimaryColor,
                      size: 24),
                ),
                SizedBox(
                  width: 4,
                ),
                // star 4
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      // color: tgDarkPrimaryColor,
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                  padding: EdgeInsets.all(5),
                  child: Icon( Icons.star,
                      color: tgDarkPrimaryColor ,
                      size: 24),
                ),
                SizedBox(
                  width: 4,
                ),
                // sar 5
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.star,
                      color:  tgDarkPrimaryColor,
                      size: 24),
                )
              ],
            ),
            SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Amenities and more",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Choose the amenities that you provide your customers, and we'll showcase this to your potential customers on your Yelp page and when you come up on search results."),
              SizedBox(
                height: 14,
              ),
              Row(children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          initialChildSize:
                              1.0, // Set to 1.0 for full screen height
                          minChildSize: 0.1, // Minimum height to stop at
                          maxChildSize:
                              1.0, // Maximum height to stop at (same as initialChildSize)
                          builder: (context, scrollController) {
                            return Container(
                                padding: EdgeInsets.all(15),
                                width: double.infinity,
                                child: AmenitiesandMoreSheet());
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // width: 100,
                    height: 40,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            Colors.grey, // You can customize the border color
                        // width: 2.0, // You can customize the border width
                      ),
                    ),

                    child: Text(
                      'View and Edit All Attributes',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Operating hours",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Choose the amenities that you provide your customers, and we'll showcase this to your potential customers on your Yelp page and when you come up on search results."),
              SizedBox(
                height: 14,
              ),
              Row(children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          initialChildSize:
                              1.0, // Set to 1.0 for full screen height
                          minChildSize: 0.1, // Minimum height to stop at
                          maxChildSize:
                              1.0, // Maximum height to stop at (same as initialChildSize)
                          builder: (context, scrollController) {
                            return Container(
                                padding: EdgeInsets.all(15),
                                width: double.infinity,
                                child: HoursOfOperations());
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // width: 100,
                    height: 40,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            Colors.grey, // You can customize the border color
                        // width: 2.0, // You can customize the border width
                      ),
                    ),

                    child: Text(
                      'View and Edit All Attributes',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // padding: EdgeInsets.all(10),
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text("Business info",
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
              ListTile(
                  title: Text("Address"),
                  subtitle: Text(
                      "National Packaging Consortium National Packaging Consortium Rome, Rome Italy"),
                  trailing: Icon(Icons.arrow_forward_ios)),
              Divider(endIndent: 20, indent: 20),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: true,
                    context: context,
                    builder: (context) {
                      return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize:
                            1.0, // Set to 1.0 for full screen height
                        minChildSize: 0.1, // Minimum height to stop at
                        maxChildSize:
                            1.0, // Maximum height to stop at (same as initialChildSize)
                        builder: (context, scrollController) {
                          return Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              child: BasicInfoForm());
                        },
                      );
                    },
                  );
                },
                child: Container(
                    child: Column(
                  children: [
                    ListTile(
                        title: Text("Call"),
                        subtitle: Text("9912277968"),
                        trailing: Icon(Icons.arrow_forward_ios)),
                    ListTile(
                        title: Text("Website"),
                        subtitle: Text("add a link to your business website",
                            style: TextStyle(color: Colors.blue)),
                        trailing: Icon(Icons.arrow_forward_ios)),
                    ListTile(
                        title: Text("Menu"),
                        subtitle: Text(
                            "Let your customers see what's on the menu",
                            style: TextStyle(color: Colors.blue)),
                        trailing: Icon(Icons.arrow_forward_ios))
                  ],
                )),
              ),
            ]),
          )
        ],
      )),
    );
  }
}
