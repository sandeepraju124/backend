import 'package:backendapp/utils/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class processing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
            "assets/analystgif.gif",
            // height: 125.0,
            // width: 125.0,
      ),
      Text("Please wait till we verify your claimed business",style: TextStyle(fontSize: 15, color: tgDarkPrimaryColor,), )
          ],
        ),
      ),
    );
  }
}
