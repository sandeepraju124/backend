// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';
import 'dart:io';
import 'package:backendapp/register/waiting.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:http/http.dart' as http;
import 'package:backendapp/provider/registrationdata.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostBusinessPage extends StatefulWidget {
  @override
  State<PostBusinessPage> createState() => _PostBusinessPageState();
}

class _PostBusinessPageState extends State<PostBusinessPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<RegistrationProvider>(context);

    String generateRandomChars(int length) {
      const chars =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random();
      return String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    }

    String generateRandomString(String category, String subCategory) {
      // Get the first 3 letters of the category and subcategory
      String categoryPrefix = category.substring(0, 3).toUpperCase();
      String subCategoryPrefix = subCategory.substring(0, 3).toUpperCase();

      // Generate random alphanumeric characters
      String randomChars = generateRandomChars(10);

      // Concatenate all parts to form the final string
      return '$categoryPrefix$subCategoryPrefix$randomChars';
    }
    String business_uid = generateRandomString(data.registrationData['category'], data.registrationData['sub_category']);

    Future<bool> postImages() async {
      try {
        final url2 = Uri.parse(
            "https://supernova1137.azurewebsites.net/post_multiple_images");
        var request = http.MultipartRequest('POST', url2);
        request.fields['business_uid'] = business_uid ;
        print(business_uid);

        if (data.registrationData['aadhar_front'] != null) {
          File aadharFrontImage =
              File(data.registrationData['aadhar_front'].path);
          File aadharBackImage =
              File(data.registrationData['aadhar_back'].path);
          request.files.add(await http.MultipartFile.fromPath(
              'aadhar_front', aadharFrontImage.path));
          request.files.add(await http.MultipartFile.fromPath(
              'aadhar_back', aadharBackImage.path));
        }

        if (data.registrationData['images'].isNotEmpty) {
          for (File image in data.registrationData['images']) {
            request.files
                .add(await http.MultipartFile.fromPath('images', image.path));
          }
        }

        var response = await request.send();

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print(responseBody);

          // return 'Service created successfully';
          return true;
        } else {
          throw Exception('Failed to send images');
        }
      } catch (e) {
        print(e.toString());
        throw Exception('Failed to send images: $e');
      }
    }

    Future<bool> postBusiness() async {
      setState(() {
        _isLoading = true;
      });

      // var data = Provider.of<RegistrationProvider>;
      print("before try");
      try {
        print("inside try");
        final url =
            Uri.parse("https://supernova1137.azurewebsites.net/pg/business");
            

        Map<String, String> body = {
          'business_uid': business_uid,
          'business_name': data.registrationData['businessName'],
          'business_description': data.registrationData['business_description'],
          'contact_information': data.registrationData['contactInfo'],
          'country': "india",
          'category': data.registrationData['category'],
          'sub_category': data.registrationData['sub_category'],
          'latitude': data.registrationData['latitude'].toString(),
          'longitude': data.registrationData['longitude'].toString()
          // 'image' : _ffsaiImage
        };
        print(" try");
        print(Random(5).nextInt(5));

        // final response = await http.post(url, body: body);
        final request = http.MultipartRequest(
          'POST',
          url,
        )
          ..files.add(await http.MultipartFile.fromPath(
              'profile_image_url', data.registrationData['profile_image_url']))
          ..fields.addAll(body);
        final response = await request.send();
        print(response.statusCode);
        print(response);
        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print(responseBody);

          setState(() {
            _isLoading = false;
            // return true;
          });

          // return 'Service created successfully';
          return true;
        } else {
          throw Exception('Failed to create service');
        }
      } catch (e) {
        print(e.toString());
        throw Exception('Failed to create service: $e');
      }
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: Color(0xFFEFF0F7),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: Image.file(
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      File(data.registrationData['profile_image_url'])),
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: data.registrationData['aadhar_front'] != null,
                  child: Text(
                    "proofs",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                Visibility(
                    visible: data.registrationData['aadhar_front'] != null,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.file(
                            data.registrationData['aadhar_front'],
                            // File(data.registrationData['images'][int]),
                            width: 90.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.file(
                            data.registrationData['aadhar_back'],
                            // File(data.registrationData['images'][int]),
                            width: 90.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    )),
                Visibility(
                  visible: data.registrationData['images'].isNotEmpty,
                  child: Text(
                    "Images",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                Visibility(
                  visible: data.registrationData['images'].isNotEmpty,
                  child: Container(
                    // color: Colors.grey,
                    height: 110,
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data.registrationData['images'].length,
                        itemBuilder: (BuildContext, int) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.file(
                              data.registrationData['images'][int],
                              // File(data.registrationData['images'][int]),
                              width: 90.0,
                              // height: 80.0,
                              fit: BoxFit.cover,
                            ),
                            // Image.network(
                            //   urls[int],
                            //   width: 100.0,
                            //   height: 80.0,
                            //   fit: BoxFit.cover,)
                          );
                        }),
                  ),
                ),
                Text(
                  "Business Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['businessName'],
                          // "Sandy Plumber",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Discription",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['business_description'],
                          // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printerpsum.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Home Services > Mobile Home Repair",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['businessEmail'],
                          // "sandeepraju124@gmail.com",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          // data.registrationData['contactInfo'],
                          "Contact",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          // "9912277968",
                          data.registrationData['contactInfo'].toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.registrationData['address'],
                          // "21302 Sipes Ridges, Sammymouth, RI 10106-8208",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Latitude and Longitude",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  data.registrationData['latitude'].toString(),
                                  // "12.211",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  data.registrationData['longitude'].toString(),
                                  // "23.013",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            )
                            // OutlinedBox(text: "12.211"),
                            // OutlinedBox(text: "23.013"),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {

            // String a = generateRandomString("hshsh", "jshhdd");
            // print(a);
            postBusiness().then((value) {
              if (value == true) {
                // navigatorPush(context, WaitingScreen());
                postImages().then((value) {
                  if (value == true) {
                    navigatorPush(context, WaitingScreen());
                  }
                });
                print(value);
              } else {
                showSnackBar(context, "error please try again");
              }
            });



            // postBusiness().then((value) {
            //   if (value == true) {
            //     navigatorPush(context, WaitingScreen());
            //     print(value);
            //   } else {
            //     showSnackBar(context, "error please try again");
            //   }
            // });

            // postImages();

            //  print(File(data.registrationData['images'][1].path));
            // print(File(data.registrationData['profile_image_url']));
            // print(data.registrationData['images'][0].path);
            // File aadharFrontImage = File(data.registrationData['images'][0].path);
            // print(aadharFrontImage.path);
          },
          child: Container(
            height: 55,
            width: double.infinity,
            color: tgAccentColor,
            child: Center(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ))
                    : Text(
                        "Create Business",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
          ),
        ),
      ),
    );
  }
}
