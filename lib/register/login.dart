// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_build_context_synchronously

import "package:backendapp/screens/redirection.dart";
import "package:backendapp/utils/constants.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool isLoading = false;

  bool _obscureText = true;

  Future signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim());
      // setState(() {
      //   isLoading = true;
      // });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => redirection()), // Use redirection widget here
      );

      // fetch users data
      // var userpro = Provider.of<UserProvider>(context, listen: false);
      // await userpro.userProvider();
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(e);
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    super.dispose();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 28,
            )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 60.0, horizontal: 30),
                  child: Lottie.asset("assets/business.json", height: 190),
                ),
                SizedBox(height: 40),
                Text("Sign In to Continue Your Journey",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      labelText: ' Email',
                      labelStyle: TextStyle(color: tgSecondaryText),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tgSecondaryText)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tgAccentColor))),
                  autofocus: false,
                  maxLines: null,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter E-mail";
                    }
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _passwordcontroller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: tgSecondaryText),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tgSecondaryText)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tgAccentColor)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        iconSize: 20,
                      )),
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Enter E-mail";
                  //   }
                  //   bool emailValid = RegExp(
                  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //       .hasMatch(value);
                  //   if (!emailValid) {
                  //     return "Enter valid email";
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    showSnackBar(context,
                        "Feature is in progress soon it will be available");
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget password",
                        style: TextStyle(color: tgDarkPrimaryColor),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    // color: tgAccentColor,
                    // color: Color(0xFF6D64FF),
                    color: Color.fromARGB(245, 59, 80, 198),
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )),
                          )
                        : Center(
                            child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
