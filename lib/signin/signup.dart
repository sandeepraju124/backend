import 'package:backendapp/signin/register.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
      Container(
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
              child: Text("Log in to your business account", style: TextStyle(color: tgPrimaryText))),

      ),
      SizedBox(height: 10,),
      GestureDetector(
        onTap: (){
          navigatorPush(context,LogIn());
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
                child: Text("Create a business account for free", style: TextStyle(color: Colors.white))),
        ),
      ),
      const SizedBox(height: 10,),
      Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 22),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: tgDividerColor),
                // color: Colors.
                ),
            child:Align(
            alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset("assets/googlelogo.png",),
                  ),
                  Text("Log in with google", style: TextStyle(color: tgPrimaryText)),
                ],
              )),
      ),
          ],
        ),
      ),
    );
  }
}