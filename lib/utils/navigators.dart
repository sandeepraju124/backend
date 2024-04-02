import 'package:flutter/material.dart';

void navigatorPush(BuildContext context,Widget page){
Navigator.push(context,MaterialPageRoute(builder: (context) =>page),);
}

void navigatorReplace(BuildContext context,Widget page){
Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>page),);
}
