// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_const_declarations

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/screens/editanswerbottomsheet.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Answerpage extends StatefulWidget {
  const Answerpage({super.key, required this.questionid});

  final String questionid; //9703fe5727

  @override
  State<Answerpage> createState() => _AnswerpageState();
}

class _AnswerpageState extends State<Answerpage> {
  final TextEditingController _answercontroller = TextEditingController();

  @override
  void dispose() {
    _answercontroller.dispose();
    _answercontroller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AskCommunityProvider>(context, listen: true);

    // var data1 = Provider.of<BusinessProfileProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tgPrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(LineAwesomeIcons.arrow_left),
          color: tgPrimaryText,
        ),
        title: Text(
          'Answers',
          style: TextStyle(color: tgPrimaryText, fontSize: 18),
        ),
      ),
      body: data.isLoading
          ? Center(
              child: CircularProgressIndicator(color: tgPrimaryColor),
            )
          : RefreshIndicator(
              onRefresh: () async {
                // Call the method to refresh the data
                // await data.fetchAskCommunityData(
                //      );
              },
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.askCommunityData!.data.length,
                itemBuilder: (BuildContext context, int questionIndex) {
                  var question = data.askCommunityData!.data[questionIndex];

                  if (question.qdetails.questionid != widget.questionid) {
                    return SizedBox.shrink();
                  }

                  var answers = question.answers;

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 13, bottom: 5),
                          child: Text(
                            "Q: ${question.question}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 360,
                          child: TextField(
                            style: TextStyle(color: secondaryColor40LightTheme),
                            controller: _answercontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Type your answer here",
                              hintStyle: TextStyle(
                                color: secondaryColor20LightTheme,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            autofocus: false,
                            maxLines: null,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          width: 360,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tgPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              data
                                  .postAnswer(context, widget.questionid,
                                      _answercontroller.text)
                                  .then((success) => {
                                        if (success)
                                          {
                                            _answercontroller.clear(),
                                            // data.fetchAskCommunityData(
                                            //     context,
                                            //     FirebaseAuth
                                            // //         .instance.currentUser!.uid)
                                            // data1.businessProfileProvider(
                                            //     FirebaseAuth
                                            //         .instance.currentUser!.uid),
                                          }
                                      });
                            },
                            child: Text(
                              "Answer",
                              style: TextStyle(color: tgPrimaryText),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        if (data.askCommunityData!.data.isNotEmpty) ...[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: tgPrimaryColor))),
                            child: Text("Previous Answers !"),
                          ),
                        ],

                        SizedBox(height: 12),

                        ////////////////////// answers display //////////////

                        for (var answer in answers)
                          GestureDetector(
                            onLongPress: () {
                              final currentuser =
                                  FirebaseAuth.instance.currentUser?.uid;
                              if (currentuser != null &&
                                  currentuser == answer.adetails.userid) {
                                showModalBottomSheet(
                                  context: context,
                                  elevation: 6,
                                  isScrollControlled: true,
                                  backgroundColor: tgLightPrimaryColor,
                                  builder: (BuildContext context) {
                                    return Wrap(
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(
                                            Icons.edit,
                                            size: 20.5,
                                          ),
                                          title: Text('Edit'),
                                          onTap: () {
                                            // Close the bottom sheet
                                            Navigator.pop(context);

                                            print(
                                                "Current user ID: $currentuser");
                                            print(
                                                "Answer ID: ${answer.adetails.answerid}");

                                            // Check if answerId is not null and not empty
                                            if (answer.adetails.answerid !=
                                                    null &&
                                                answer.adetails.answerid!
                                                    .isNotEmpty) {
                                              // Open the new modal bottom sheet after a delay
                                              Future.delayed(Duration.zero, () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom,
                                                      ),
                                                      child:
                                                          EditAnswerBottomSheet(
                                                        businessUid: data
                                                            .askCommunityData!
                                                            .businessUid,
                                                        questionId: question
                                                            .qdetails
                                                            .questionid,
                                                        currentAnswerText:
                                                            answer.answer ?? "",
                                                        answerId: answer
                                                                .adetails
                                                                .answerid ??
                                                            "",
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                            } else {
                                              // Handle the case where answerId is null or empty
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Error: answerId is missing or invalid"),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.delete,
                                            size: 20.5,
                                          ),
                                          title: Text('Delete'),
                                          onTap: () {
                                            // Close the bottom sheet
                                            Navigator.pop(context);
                                            // Show confirmation dialog
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext dialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Confirm Delete',
                                                    style: TextStyle(
                                                        color:
                                                            tgDarkPrimaryColor),
                                                  ),
                                                  content: Text(
                                                      'Are you sure you want to delete this question?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(
                                                                  dialogContext)
                                                              .pop(false),
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                tgDarkPrimaryColor),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(
                                                                dialogContext)
                                                            .pop();

                                                        await data
                                                            .deleteAnswer(
                                                          context,
                                                          data.askCommunityData!
                                                              .businessUid,
                                                          question.qdetails
                                                              .questionid,
                                                          answer.adetails
                                                                  .answerid ??
                                                              "",
                                                        )
                                                            .then((success) {
                                                          if (success) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    "Question deleted Successfully"),
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                              ),
                                                            );
                                                          } else {
                                                            // Optionally, show an error message if the deletion failed
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    "Failed to delete question"),
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                              ),
                                                            );
                                                          }
                                                          Navigator.of(
                                                                  dialogContext)
                                                              .pop();
                                                        });
                                                      },
                                                      child: Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            color:
                                                                tgDarkPrimaryColor),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Oops! This answer can only be edited or removed by its original poster.",
                                    style: TextStyle(fontSize: 12.5),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ));
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  color: tgLightPrimaryColor,
                                  elevation: 0.9,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("A: ${answer.answer}"),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.4,
                                  indent: 0.6,
                                  endIndent: 0.6,
                                )
                              ],
                            ),
                          ),
                        SizedBox(height: 10),

                        Center(
                          child: Card(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Ans: ${answers.length}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
