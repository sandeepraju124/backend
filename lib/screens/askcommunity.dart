// ignore_for_file: prefer_const_constructors, use_super_parameters, library_private_types_in_public_api
import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/screens/answers.dart';
import 'package:backendapp/screens/question.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:lottie/lottie.dart';

class AskForCommunityWidget extends StatefulWidget {
  const AskForCommunityWidget(
      {Key? key, required this.uid, required this.Questionid})
      : super(key: key);

  final String uid; // ""
  final String Questionid; // ""

  @override
  _AskForCommunityWidgetState createState() => _AskForCommunityWidgetState();
}

class _AskForCommunityWidgetState extends State<AskForCommunityWidget> {
  int displayQuestionCount = 10;
  Map<int, bool> showRemainingAnswers = {};

  // ignore: non_constant_identifier_names

  // @override
  // void initState() {
  //   super.initState();
  //   // var data = Provider.of<AskCommunityProvider>(context, listen: false);
  //   // data.askCommunityProvider(widget.uid);
  // }

  void showAllQuestions() {
    var data = Provider.of<AskCommunityProvider>(context, listen: true);
    setState(() {
      displayQuestionCount = data.askCommunityData?.data.length ?? 0;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Questionpage(
          id: '',
        );
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AskCommunityProvider>(context, listen: true);

    // Use a local variable to simplify null checks
    var askCommunityData = data.askCommunityData;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              // Text(
              //   " Ask Your Community",
              //   style: TextStyle(
              //       fontSize: 17,
              //       fontWeight: FontWeight.w400,
              //       color: tgPrimaryText),
              // ),
              Container(
                height: 03,
                width: 90,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: tgPrimaryColor))),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Questionpage(
                        id: '',
                      );
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tgPrimaryColor, elevation: 5),
                  child: Text(
                    "Would you like to Know (or) Ask anything ?",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                height: 10,
              ),
              // Divider(
              //   endIndent: 5,
              //   indent: 5,
              //   color: Colors.grey, // Optional - set the color of the divider
              //   thickness: 1, // Optional - set the thickness of the divider
              // ),
              if (askCommunityData != null &&
                  askCommunityData.data.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 220, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: tgPrimaryColor))),
                        child: Text("Commmunity Questions"),
                      )
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
        data.isLoading
            ? Center(child: CircularProgressIndicator(color: tgPrimaryColor))
            : askCommunityData == null || askCommunityData.data.isEmpty
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Image.asset("assets/pool.png", height: 100),
                        // Lottie.asset("assets/Ask.json", height: 260),
                        SizedBox(height: 13),
                        Text(
                          "Got questions? Your community has answers!",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ))
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        min(displayQuestionCount, askCommunityData.data.length),
                    itemBuilder: (BuildContext context, int int) {
                      var question = data.askCommunityData!.data[int];
                      var answers = question.answers;

                      var hasRemainingAnswers = answers.length > 2 &&
                          !showRemainingAnswers.containsKey(int);
                      return GestureDetector(
                        onTap: () {
                          navigatorPush(
                              context,
                              Answerpage(
                                  questionid: question.qdetails.questionid));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              // border: ,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("testing"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return Answerpage(
                                    //       questionid:
                                    //           question.qdetails.questionid);
                                    // }));
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: EdgeInsets.all(5),
                                    // width: double.infinity,
                                    // decoration: BoxDecoration(
                                    //     color: secondaryColor10LightTheme),
                                    child: Text(
                                      maxLines: 1,
                                      "Q: ${question.question}",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    hasRemainingAnswers ? 2 : answers.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "A: ${answers[index].answer}",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                              if (hasRemainingAnswers)
                                GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   showRemainingAnswers[int] = true;
                                    // });

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Answerpage(
                                          questionid: widget.Questionid);
                                    }));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    height: 30,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: secondaryColor20LightTheme),
                                    ),
                                    child: Text(
                                        "Show ${answers.length - 2} more answers"),
                                  ),
                                )
                              else if (int == displayQuestionCount - 1 &&
                                  displayQuestionCount <
                                      data.askCommunityData!.data.length)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Questionpage(
                                        id: '',
                                      );
                                    }));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    height: 30,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: secondaryColor20LightTheme),
                                    ),
                                    child: Text(
                                        "Show ${data.askCommunityData!.data.length - displayQuestionCount} more questions"),
                                  ),
                                ),
                              // const Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ],
    );
  }
}
