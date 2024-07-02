// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:backendapp/register/onboardingService.dart';
import 'package:backendapp/register/location_search_screen.dart';
import 'package:backendapp/screens/redirection.dart';
// import 'package:backendapp/screens/map.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  File? _profile_image_url;
  bool _isLoading = false;

  Future imagePicker(ImageSource source) async {
    ImagePicker pick = ImagePicker();
    final pickedFile = await pick.pickImage(source: source);
    setState(() {
      _profile_image_url = File(pickedFile!.path);
    });
  }

  bool _obscureText = true;

  // Future postUser(userid) async {

  // Map<String, String> body = {
  //       // 'name': _firstnamecontroller.text.trim(),
  //       'email': _emailcontroller.text.trim(),
  //       "username": _lastnamecontroller.text.trim(),
  //       "userid": userid.toString(),
  //       "business_uid":"jhbegf"
  //     };
  //     final url = Uri.parse('https://supernova1137.azurewebsites.net/pg/business');
  //     // final jsonData = json.encode(body);

  // String selectedGender = "";

  Future signup() async {
    setState(() {
      _isLoading = true;
    });

    print('Sign up clicked');
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim());

      final user = FirebaseAuth.instance.currentUser;
      final userid = user?.uid;

      Map<String, String> body = {
        "name": _firstnamecontroller.text.trim(),
        "email": _emailcontroller.text.trim(),
        "username": _lastnamecontroller.text.trim(),
        "userid": userid.toString(),
        "business_account": "true"
      };

      final request = http.MultipartRequest(
          "POST",
          Uri.parse(
            "$baseUrl/user",
          ));
      if (_profile_image_url != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'profile_image_url', _profile_image_url!.path));
      }
      // ..files.add(await http.MultipartFile.fromPath('dp', _dp!.path))
      request.fields.addAll(body);

      final response = await request.send();
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print(responseBody);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  redirection()), // Use redirection widget here
        );
        setState(() {
          _isLoading = false;
        });

        //fetch data and store on provider
        // userpro.userProvider();

        print('user created successfully');
        return responseBody;
      } else {
        throw Exception('Failed to create user');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    } catch (e) {
      print(e.toString());
      throw Exception('EXception Failed to create user : $e');
    }
  }

  Gender? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            "REGISTRATION",
            style: TextStyle(color: Colors.black),
          )),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 65,
                child: Container(
                  // color: Colors.red,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            controller: _firstnamecontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                              labelText: 'First name',
                            ),
                            autofocus: false,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                          ),
                          TextField(
                            controller: _lastnamecontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                              labelText: 'Last name',
                            ),
                            autofocus: false,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                          ),
                        ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  imagePicker(ImageSource.gallery);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[200],
                  height: 150,
                  child:
                      // Image.network(
                      // "https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg")
                      _profile_image_url == null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/defaulltdp.png"))
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_profile_image_url!),
                            ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGenderOption(Gender.male, "Male"),
              _buildGenderOption(Gender.female, "Female"),
              _buildGenderOption(Gender.preferNotToSay, "prefer not to say")
            ],
          ),
          SizedBox(
            height: 6,
          ),
          const Divider(
            height: 4,
            thickness: 3,
            color: secondaryColor10LightTheme,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                labelText: ' Email',
              ),
              autofocus: false,
              maxLines: null,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              obscureText: _obscureText,
              controller: _passwordcontroller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )),
              autofocus: false,
              maxLines: 1,
              // expands:true,
              // minLines: 1,
              maxLength: 250,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
        ],
      )),
      bottomNavigationBar: InkWell(
        onTap: () {
          signup();
          // navigatorPush(context,AddService() );
          // navigatorPush(context,SearchLocationScreen() );
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
                      "Join",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
        ),
      ),
    );
  }

  Widget _buildGenderOption(Gender gender, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(16),
            color: _selectedGender == gender
                ? tgLightPrimaryColor
                : Colors.grey[200]),
        child: Text(label),
      ),
    );
  }
}

enum Gender { male, female, preferNotToSay }
