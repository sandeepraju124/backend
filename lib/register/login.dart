// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_build_context_synchronously

import "package:backendapp/screens/redirection.dart";
import "package:backendapp/utils/constants.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool isLoading = false;

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
      MaterialPageRoute(builder: (context) => redirection()), // Use redirection widget here
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
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lets Sign You in",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
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
                controller: _passwordcontroller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                height: 5,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forget password",
                    style: TextStyle(color: Colors.teal),
                  )),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  // color: tgAccentColor,
                  color: Color(0xFF6D64FF),
                  child: isLoading ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)): Center(
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
    );
  }
}
