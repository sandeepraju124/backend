// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/provider/commentprovider.dart';
import 'package:backendapp/provider/house_provider.dart';
import 'package:backendapp/screens/add_photos.dart';
import 'package:backendapp/screens/amenites/diaplay_amenities.dart';
import 'package:backendapp/screens/home/homepage.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:backendapp/screens/amenites/AmenitiesandMore.dart';
import 'package:backendapp/widgets/Businessinfo.dart';
import 'package:backendapp/widgets/house_overview.dart';
import 'package:backendapp/widgets/operating_hours_test.dart';
import 'package:backendapp/widgets/rating.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BusinessInfoHub extends StatefulWidget {
  @override
  State<BusinessInfoHub> createState() => _BusinessInfoHubState();
}

class _BusinessInfoHubState extends State<BusinessInfoHub> {
  final Map<String, String> openingHours = {
    'Monday': '9:00 AM - 5:00 PM',
    'Tuesday': '9:00 AM - 5:00 PM',
    'Wednesday': 'Closed',
    'Thursday': 'Closed',
    'Friday': 'Closed',
    'Saturday': 'Closed',
    'Sunday': 'Closed',
  };

  String noAmenities = "No amenities added, add them to engage with customers";

  String _formatTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1].substring(0, 2); // Extract minutes
    final meridiem = hour >= 12 ? 'PM' : 'AM'; // Determine meridiem
    final hour12 =
        hour % 12 == 0 ? 12 : hour % 12; // Convert hour to 12-hour format
    return '$hour12:$minute $meridiem'; // Construct formatted time string
  }

  String _operatingHoursMsg =
      "Choose the amenities that you provide your customers, and we'll showcase this to your potential customers on your Yelp page and when you come up on search results";

  

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ServicesProvider>(context);
    var businessdata = Provider.of<BusinessDataProvider>(context);
    String _ratingString = Provider.of<CommentSectionProvider>(context)
            .averageRating
            .toStringAsFixed(0) ??
        "0";
    int _rating = int.parse(_ratingString);
    print("Rating: $_rating");
    print("RatingString: $_ratingString");

    print("hereeeeeeeee");
    print(data.BusinessData?.operatingHours);
    print(data.BusinessData?.businessUid);
    var amenities = data.BusinessData?.amenities;
    var operatingHours = data.BusinessData?.operatingHours;

    // final List<Map<String, dynamic>> openingHours = data.BusinessData.openingHours;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: tgDarkPrimaryColor,
        title: Text(
          "Business Info Hub",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // data.getMongoBusinessData();
              showSnackBar(context, "Business Info Hub");
            },
            icon: Icon(Icons.add_business_outlined),
          )
        ],
      ),
      body: businessdata.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: tgPrimaryColor,
            ))
          : SafeArea(
              child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Stack(clipBehavior: Clip.none, children: [
                  SlidingCoverImages(),
                  // Container(
                  //     height: 140,
                  //     width: double.infinity,
                  //     // color: Colors.blue,
                  //     child: Image(
                  //       image: NetworkImage(
                  //           "https://images.unsplash.com/photo-1501862700950-18382cd41497?auto=format&fit=crop&q=80&w=2019&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                  //       fit: BoxFit.cover,
                  //     )),
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
                            (businessdata.BusinessData != null &&
                                    businessdata.BusinessData!.isNotEmpty)
                                ? businessdata
                                        .BusinessData![0].profileImageUrl ??
                                    "https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg"
                                : "https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: ClipOval(
                        //     child: Image.network(
                        //         businessdata.BusinessData![0].profileImageUrl ??
                        //             "https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg",
                        //         fit: BoxFit.cover)
                        //     ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Community();

                                      // navigatorPush(
                                      //     context, Homepage(initialIndex: 3));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Homepage(initialIndex: 3)));
                                    },
                                    child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(5)),

                                      child: Text(
                                        'See reviews',
                                        style: TextStyle(
                                            color: tgDarkPrimaryColor),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      navigatorPush(context, AddPhotos());
                                    },
                                    child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(5)),

                                      child: Text(
                                        'Add photos',
                                        style: TextStyle(
                                            color: tgDarkPrimaryColor),
                                      ),
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
                                        borderRadius: BorderRadius.circular(5)),

                                    child: Text(
                                      'View ',
                                      style:
                                          TextStyle(color: tgDarkPrimaryColor),
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
                // Text("Sandeep Raju"),
                // Text(businessdata.BusinessData![0].businessName),
                // Text(
                //   businessdata.BusinessData![0].businessName,
                //   style: TextStyle(
                //     fontSize: 25,
                //     fontWeight: FontWeight.bold,
                //     // color: Colors.grey, // Example color
                //     // Add more properties as needed
                //   ),
                // ),
                Text(
                  (businessdata.BusinessData != null &&
                          businessdata.BusinessData!.isNotEmpty)
                      ? businessdata.BusinessData![0].businessName
                      : 'Default Business Name',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    // color: Colors.grey, // Example color
                    // Add more properties as needed
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // Text(
                //   Provider.of<CommentSectionProvider>(context)
                //       .averageRating
                //       .toStringAsFixed(1),
                //   style: TextStyle(
                //       color: Colors.black87,
                //       fontSize: 13,
                //       fontWeight: FontWeight.w400),
                // ),
                // Text(
                //   Provider.of<CommentSectionProvider>(context)
                //       .averageRating
                //       .toStringAsFixed(0),
                //   style: TextStyle(
                //       color: Colors.black87,
                //       fontSize: 13,
                //       fontWeight: FontWeight.w400),
                // ),

                StarRating(
                  rating: _rating,
                  filledStarColor: tgDarkPrimaryColor, // Adjust as needed
                  unfilledStarColor: Colors.grey, // Adjust as needed
                ),

                // Text("***********"),
                // Row(
                //   children: [
                //     // star 1
                //     Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(3)),
                //       padding: EdgeInsets.all(5),
                //       child:
                //           Icon(Icons.star, color: tgDarkPrimaryColor, size: 24),
                //     ),
                //     SizedBox(
                //       width: 4,
                //     ),
                //     // star 2
                //     Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(3)),
                //       padding: EdgeInsets.all(5),
                //       child:
                //           Icon(Icons.star, color: tgDarkPrimaryColor, size: 24),
                //     ),
                //     SizedBox(
                //       width: 4,
                //     ),
                //     // star 3
                //     Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(3)),
                //       padding: EdgeInsets.all(5),
                //       child:
                //           Icon(Icons.star, color: tgDarkPrimaryColor, size: 24),
                //     ),
                //     SizedBox(
                //       width: 4,
                //     ),
                //     // star 4
                //     Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           // color: tgDarkPrimaryColor,
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(3)),
                //       padding: EdgeInsets.all(5),
                //       child:
                //           Icon(Icons.star, color: tgDarkPrimaryColor, size: 24),
                //     ),
                //     SizedBox(
                //       width: 4,
                //     ),
                //     // sar 5
                //     Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(3)),
                //       padding: EdgeInsets.all(5),
                //       child:
                //           Icon(Icons.star, color: tgDarkPrimaryColor, size: 24),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),
                BusinessSpecific(businessdata.BusinessData![0].subCategory),
                SizedBox(
                  height: 10,
                ),

                // SlidingCoverImages(),

                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Amenities and more",
                                style: TextStyle(
                                    fontSize: 22.4,
                                    fontWeight: FontWeight.w600)),
                            GestureDetector(
                                onTap: () {
                                  navigatorPush(context, AmenityScreen());
                                },
                                child: Text(
                                  "view all",
                                  style: TextStyle(color: Colors.teal),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // data.BusinessData!.amenities == null  ||  data.BusinessData!.amenities!.isEmpty   ? Text(noAmenities):
                        amenities == null || amenities.isEmpty
                            ? Text(noAmenities)
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: amenities.length <= 3
                                    ? amenities.length
                                    : 3,
                                itemBuilder: (BuildContext, int) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(amenities[int]),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Yes",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }),

                        // Row(
                        //   children: [
                        //     Icon(Icons.car_crash),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text("Offer Delivery"),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Yes",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.car_crash),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text("WheelChair Accessible"),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Yes",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.car_crash),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text("Plastic Free packaing"),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Yes",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.car_crash),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text("Bring your own containers allowed"),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Yes",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Text(
                        //     "Choose the amenities that you provide your customers, and we'll showcase this to your potential customers on your Yelp page and when you come up on search results."),
                        SizedBox(
                          height: 16,
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
                                    minChildSize:
                                        0.1, // Minimum height to stop at
                                    maxChildSize:
                                        1.0, // Maximum height to stop at (same as initialChildSize)
                                    builder: (context, scrollController) {
                                      return AmenitiesandMoreSheet();
                                      // Container(
                                      //     padding: EdgeInsets.all(15),
                                      //     width: double.infinity,
                                      //     child: AmenitiesandMoreSheet()
                                      //     );
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
                                        secondaryColor20LightTheme, // You can customize the border color
                                    // width: 2.0, // You can customize the border width
                                  ),
                                  borderRadius: BorderRadius.circular(5)),

                              child: Text(
                                'View and Edit All 9 Attributes',
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Operating hours",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600)),
                            GestureDetector(
                                onTap: () {
                                  // data.getMongoBusinessData();
                                  showSnackBar(context, _operatingHoursMsg);
                                },
                                child: Icon(Icons.mode_comment_outlined))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        operatingHours == null
                            ? Text("No operating hours available")
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: operatingHours
                                    .toJson()
                                    .entries
                                    .map((entry) {
                                  var day = entry.key;
                                  var hours = entry.value;
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(day,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 10),
                                      Text(
                                        "Open: ${hours['open'] ?? 'N/A'}",
                                      ),
                                      // Text("Close: ${hours['close'] ?? 'N/A'}"),
                                      // Text("Closed: ${hours['closed'] ? 'Yes' : 'No'}"),
                                      // Text("Open 24 hours: ${hours['open24'] ? 'Yes' : 'No'}"),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                }).toList(),
                              ),
                        // data.BusinessData?.operatingHours == null ? Text(""): Text("Update Operating Hours "),
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child:
                        //   Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: data.BusinessData!
                        //         .map((openingHour) {
                        //       final day = openingHour.day;
                        //       final hoursList = openingHour.openingTime;
                        //       final hours = hoursList!.isNotEmpty
                        //           ? hoursList
                        //               .map((hour) =>
                        //                   '${_formatTime(hour.startTime!)} - ${_formatTime(hour.endTime!)}')
                        //               .join(', ')
                        //           :
                        //           'Closed';
                        //       return Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             day!,
                        //             style: const TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //           const SizedBox(width: 8.0),
                        //           Text(hours),
                        //         ],
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),

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
                                    minChildSize:
                                        0.1, // Minimum height to stop at
                                    maxChildSize:
                                        1.0, // Maximum height to stop at (same as initialChildSize)
                                    builder: (context, scrollController) {
                                      return SafeArea(
                                        child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(15),
                                            width: double.infinity,
                                            // child: HoursOfOperations());
                                            child: OperatingHoursScreen()),
                                      );
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
                                    color: Colors
                                        .grey, // You can customize the border color
                                    // width: 2.0, // You can customize the border width
                                  ),
                                  borderRadius: BorderRadius.circular(5)),

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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text("Business info",
                              style: TextStyle(
                                fontSize: 30,
                              )),
                        ),
                        ListTile(
                            title: Text(
                              "Address",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            // subtitle: Text(
                            //     businessdata.BusinessData![0].address == null
                            //         ? "Please add address"
                            //         : businessdata.BusinessData![0].address
                            //             .toString()
                            //     // "National Packaging Consortium National Packaging Consortium Rome, Rome Italy"
                            //     ),
                            subtitle: Text(
                              (businessdata.BusinessData != null &&
                                      businessdata.BusinessData!.isNotEmpty &&
                                      businessdata.BusinessData![0].address !=
                                          null)
                                  ? businessdata
                                          .BusinessData![0].address!.isNotEmpty
                                      ? businessdata.BusinessData![0].address!
                                      : "Please add address"
                                  : "Please add address",
                              // "National Packaging Consortium National Packaging Consortium Rome, Rome Italy"
                            ),
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
                                  minChildSize:
                                      0.1, // Minimum height to stop at
                                  maxChildSize:
                                      1.0, // Maximum height to stop at (same as initialChildSize)
                                  builder: (context, scrollController) {
                                    return Container(
                                        color: Colors.white,
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
                                  title: Text(
                                    "Call",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  // subtitle: Text("9912277968"),
                                  subtitle: Text(
                                    (businessdata.BusinessData != null &&
                                            businessdata
                                                .BusinessData!.isNotEmpty)
                                        ? businessdata.BusinessData![0]
                                                .contactInformation.isNotEmpty
                                            ? businessdata.BusinessData![0]
                                                .contactInformation
                                            : "Please add contact information"
                                        : "Please add contact information",
                                  ),
                                  // Text(businessdata.BusinessData![0].contactInformation),
                                  // subtitle: Text(businessdata
                                  //     .BusinessData![0].contactInformation),
                                  trailing: Icon(Icons.arrow_forward_ios)),
                              ListTile(
                                  title: Text(
                                    "Email",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  // subtitle: Text("9912277968"),
                                  subtitle: Text(
                                      // (businessdata.BusinessData != null &&
                                      //         businessdata
                                      //             .BusinessData!.isNotEmpty)
                                      //     ? businessdata.BusinessData![0]
                                      //             .businessEmail.isNotEmpty
                                      //         ? businessdata.BusinessData![0]
                                      //             .businessEmail
                                      //         : "Please add email address"
                                      //     : "Please add email address",
                                      (businessdata.BusinessData![0].businessEmail !=null && businessdata.BusinessData![0].businessEmail.isNotEmpty)
                                          ? businessdata.BusinessData![0].businessEmail
                                          : "Please add email address"),
                                  // Text(businessdata.BusinessData![0].contactInformation),
                                  // subtitle: Text(businessdata
                                  //     .BusinessData![0].contactInformation),
                                  trailing: Icon(Icons.arrow_forward_ios)),
                              ListTile(
                                  title: Text(
                                    "Website",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                      "add a link to your business website",
                                      style: TextStyle(color: Colors.blue)),
                                  trailing: Icon(Icons.arrow_forward_ios)),
                              ListTile(
                                  title: Text(
                                    "Menu",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
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

  Widget SlidingCoverImages() {
    var data = Provider.of<ServicesProvider>(context);
    var images = data.BusinessData?.images;

    if (images == null || images.isEmpty) {
      return Center(
        // child: Text('No images available'),
        child: Image.network(height: 100,
          "https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg",fit: BoxFit.cover,),
      );
    }
    return CarouselSlider.builder(
      itemCount: data.BusinessData!.images!.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Image.network(
          // data.BusinessData!.images![index],
          images[index],
          fit: BoxFit.cover,
          width: double.infinity,
        );
      },
      options: CarouselOptions(
        height: 150,
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
    );
  }


  Widget BusinessSpecific(String subcategory) {
    switch (subcategory) {
      case "Fullhouse":
        return OverviewScreen();
      case "Plumbers":
        return OverviewScreen();
      case 'Carpenters':
        return Column(children: const [
          Text("this is 4"),
          Text("this is 5"),
        ]);
      default:
        return Text("No Specific data available");
    }
  }



}
