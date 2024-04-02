// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:backendapp/provider/registrationdata_provider.dart';
import 'package:backendapp/register/postbusiness.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PostBusiness extends StatefulWidget {
  const PostBusiness({super.key});

  @override
  State<PostBusiness> createState() => _PostBusinessState();
}

class _PostBusinessState extends State<PostBusiness> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<RegistrationProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Temporary screen to post data")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Business name: ${data.registrationData['businessName']}'),
            Text('Business email: ${data.registrationData['businessEmail']}'),
            Text('Contact Info: ${data.registrationData['contactInfo']}'),
            // const Text('Password: *****'),
            Text('Address : ${data.registrationData['address']}'),
            Text('latitude : ${data.registrationData['latitude']}'),
            Text('longitude : ${data.registrationData['longitude']}'),
            Text(
                'profile_image_url : ${data.registrationData['profile_image_url']}'),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Future<void> postBusiness() async {
                    // var data = Provider.of<RegistrationProvider>;
                    print("before try");
                    try {
                      print("inside try");
                      final url = Uri.parse(
                          // "https://supernova1137.azurewebsites.net/testingdataimageupdate");
                          "https://supernova1137.azurewebsites.net/pg/business");
                      // final url = Uri.parse('https://revolution.azurewebsites.net/services');
                      // final headers = {'Content-Type': 'application/json'};

                      Map<String, String> body = {
                        'business_uid': "dodntknowbutsearchjj",
                        'business_name': data.registrationData['businessName'],
                        'business_description':
                            data.registrationData['business_description'],
                        'contact_information':
                            data.registrationData['contactInfo'],
                        'country': "india",
                        'category': data.registrationData['category'],
                        'sub_category': data.registrationData['sub_category'],
                        'latitude':
                            data.registrationData['latitude'].toString(),
                        'longitude':
                            data.registrationData['longitude'].toString()
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
                            'profile_image_url',
                            data.registrationData['profile_image_url']))
                        ..fields.addAll(body);
                      final response = await request.send();
                      print(response.statusCode);
                      print(response);
                      if (response.statusCode == 200) {
                        final responseBody =
                            await response.stream.bytesToString();
                        print(responseBody);
                        // return 'Service created successfully';
                      } else {
                        throw Exception('Failed to create service');
                      }
                    } catch (e) {
                      print(e.toString());
                      throw Exception('Failed to create service: $e');
                    }
                  }

                  postBusiness();
                },
                child: Text("register business")),

            // Text('Latitude: ${widget.lat }',),
            // Text('Langitude: ${widget.lang }'),
            // Text('image name : ${fileName}'),
            // Text(' : ${.text}'),
            GestureDetector(
                onTap: () {
                  navigatorPush(context, PostBusinessPage());
                },
                child: Text("click")),
          ],
        ),
      ),
    );
  }
}
