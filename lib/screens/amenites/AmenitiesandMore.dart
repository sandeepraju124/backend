// ignore_for_file: prefer_const_constructors

import 'package:backendapp/provider/businessdata_provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/screens/amenites/amenites_list.dart';
import 'package:backendapp/screens/amenites/amenity_selector.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AmenitiesandMoreSheet extends StatefulWidget {
  const AmenitiesandMoreSheet({
    super.key,
  });

  @override
  State<AmenitiesandMoreSheet> createState() => _AmenitiesandMoreSheetState();
}

class _AmenitiesandMoreSheetState extends State<AmenitiesandMoreSheet> {
  String? _selected;
  Map<String, List<String>> selectedAmenities = {};

  void handleAmenitiesChanged(Map<String, List<String>> amenities) {
    setState(() {
      selectedAmenities = amenities;
    });
  }

  void postSelectedAmenities() async {
    // Extract business UID
    String businessUid = await getBusinessUid(context);
    print('Business UID: $businessUid');

    // Extract selected amenities
    // Map<String, List<String>> selectedAmenities = Provider.of<BusinessDataProvider>(context, listen: false).selectedAmenities;
    List<String> amenitiesToAddOrUpdate = [];
    List<String> amenitiesToRemove = [];
    selectedAmenities.forEach((key, value) {
      if (value.isNotEmpty) {
        amenitiesToAddOrUpdate.add(key);
      } else {
        amenitiesToRemove.add(key);
      }
    });

    // Call the function to post amenities
    bool isCheck = await Provider.of<ServicesProvider>(context, listen: false)
        .postAmenities(businessUid, amenitiesToAddOrUpdate, amenitiesToRemove);

    if (isCheck) {
      showSnackBar(context, "Amenities updated successfully");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<BusinessDataProvider>(context);
    // print(data.BusinessData![0].category);
    // print(data.BusinessData![0].subCategory);
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(toolbarHeight: 120, title: Text("Amenities and more")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            // SizedBox(
            //   height: 10,
            // ),
            Text(
                "Choose the amenities that you provide your customers, and we'll showcase this to your potential customers on your Yelp page and when you come up on search results.",
                style: TextStyle(fontSize: 12)),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                SvgPicture.asset("assets/svg/business-report-svgrepo-com.svg",
                    height: 55),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Show your customers",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // accessibility(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AmenitySelector(
                      // amenities: amenities,
                      amenities: AmenityList.getAmenitiesByCategory(
                          // "Hotels_Accommodations"
                          // "Hotels_Accodations"
                          // if the subCategory is not present int the list then it will point to default
                          data.BusinessData![0].subCategory),
                      subOptions: subOptions,
                      onChanged: handleAmenitiesChanged,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: postSelectedAmenities,
                      child: Text('Post Selected Amenities'),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Expanded accessibility() {
    return Expanded(
      child: SizedBox(
        child: SingleChildScrollView(
            child: Column(
          children: [
            // SizedBox(
            //   height: 300,
            // ),

            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6)),
              padding: EdgeInsets.all(10),
              height: 90,
              width: double.infinity,
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 40,
                    child: Container(
                      child: Text(
                        "Accessibility",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 60,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text("Accepts Debit Cards"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selected = 'Yes';
                                        print(_selected);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _selected == 'Yes'
                                          ? Colors.teal
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: _selected == "Yes"
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selected = 'No';
                                        print(_selected);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _selected == 'No'
                                          // ? Colors.red
                                          // : Colors.grey[150],
                                          ? Colors.teal
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text('No',
                                        style: TextStyle(
                                            color: _selected == "No"
                                                ? Colors.white
                                                : Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 300,
            // ),
            // Container(),
            // Container(),
            // Container(),
          ],
        )),
      ),
    );
  }
}
