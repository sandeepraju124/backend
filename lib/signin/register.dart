import 'package:backendapp/screens/add_service_screens/addService.dart';
import 'package:backendapp/screens/location_search_screen.dart';
// import 'package:backendapp/screens/map.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // String selectedGender = "";
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
                        children: const [
                          TextField(
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
              Expanded(
                flex: 35,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[200],
                  height: 150,
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://expertphotography.b-cdn.net/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg"),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              autofocus: false,
              maxLines: null,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          
        ],
      )),
      bottomNavigationBar: InkWell(
        onTap: (){
          navigatorPush(context,SearchLocationScreen() );
        },
        child: Container(
          height: 55,
          width: double.infinity,
          color: tgAccentColor,
          child: Center(child: Text("Join", style: TextStyle(color: Colors.white, fontSize: 17),)),
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
