import 'package:backendapp/register/login.dart';
import 'package:backendapp/register/register.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: cross,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Welcome aboard! At NearReMe (BIZ)',
                          style: TextStyle(

                              // color: Colors.deepPurple.shade900,
                              // Color tgDarkPrimaryColor: Color(#00796B),
                              color: tgDarkPrimaryColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "we'll make managing your business a seamless experience",
                          style: TextStyle(
                              color: tgSecondaryText,
                              fontSize: 13.6,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Lottie.asset("assets/business.json", height: 190),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    navigatorPush(context, Login());
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: tgDividerColor),
                      // borderRadius: BorderRadius.circular(16),
                      // color: tgDarkPrimaryColor
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Log in to your business account",
                            style: TextStyle(color: tgPrimaryText))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorPush(context, SignupPage());
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(16),
                        color: tgDarkPrimaryColor),
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text("Create a business account for free",
                            style: TextStyle(color: Colors.white))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showSnackBar(context,
                        "Feature is in progress soon it will be available");
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: tgDividerColor),
                      // color: Colors.
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                "assets/googlelogo.png",
                              ),
                            ),
                            Text("Log in with google",
                                style: TextStyle(color: tgPrimaryText)),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
