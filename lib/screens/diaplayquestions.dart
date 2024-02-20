// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/screens/answers.dart';
import 'package:backendapp/screens/editquestionbottomsheet.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:provider/provider.dart";
import 'package:flutter/material.dart';

class displayQuestions extends StatefulWidget {
  displayQuestions({
    super.key,
  });

  @override
  State<displayQuestions> createState() => _displayQuestionsState();
}

class _displayQuestionsState extends State<displayQuestions> {
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AskCommunityProvider>(context);
    return data.isLoading
        ? Center(
            child: CircularProgressIndicator(color: tgPrimaryColor),
          )
        : RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.askCommunityData!.data.length,
              itemBuilder: (BuildContext context, int questionIndex) {
                var question = data.askCommunityData!.data[questionIndex];
                var answers = question.answers;

                // Create a list of widgets to hold the question and answers in a single box
                List<Widget> questionAndAnswers = [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        print(question.qdetails.questionid);
                        return Answerpage(
                            questionid: question.qdetails.questionid);
                      }));
                    },
                    onLongPress: () {
                      final currentuser =
                          FirebaseAuth.instance.currentUser?.uid;

                      if (currentuser != null &&
                          currentuser == question.qdetails.userid) {
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

                                    // Open the new modal bottom sheet after a delay
                                    Future.delayed(Duration.zero, () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: EditQuestionbottomsheet(
                                              businessUid: data
                                                  .askCommunityData!
                                                  .businessUid,
                                              questionId:
                                                  question.qdetails.questionid,
                                              currentQuestionText:
                                                  question.question,
                                            ),
                                          );
                                        },
                                      );
                                    });
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
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                            'Confirm Delete',
                                            style: TextStyle(
                                                color: tgDarkPrimaryColor),
                                          ),
                                          content: Text(
                                              'Are you sure you want to delete this question?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(dialogContext)
                                                      .pop(false),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: tgDarkPrimaryColor),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(dialogContext)
                                                    .pop();

                                                await data
                                                    .deleteQuestion(
                                                  context,
                                                  question.qdetails.questionid,
                                                  currentuser,
                                                  data.askCommunityData!
                                                      .businessUid,
                                                )
                                                    .then((success) {
                                                  if (success) {
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                });
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: tgDarkPrimaryColor),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Oops! This question can only be edited or removed by its original poster.",
                            style: TextStyle(fontSize: 12.5),
                          ),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    },
                    child: Container(
                      color: Colors
                          .grey[200], // Light grey background for questions
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Q: ${question.question} ",
                          style: TextStyle(
                              fontSize: 13.7, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ];
                for (int i = 0; i < 2 && i < answers.length; i++) {
                  questionAndAnswers.add(
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: secondaryColor10LightTheme),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "A: ${answers[i].answer}",
                          style: TextStyle(
                            fontSize: 13,
                            color: secondaryColor20LightTheme,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // Add answers to the list
                if (answers.length > 2) {
                  // If there are more than 2 answers, show "Show More Answers" button
                  questionAndAnswers.add(
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Answerpage(
                              questionid: question.qdetails.questionid);
                        }));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: tgPrimaryColor,
                          border: Border.all(color: secondaryColor20LightTheme),
                        ),
                        child: Text("Show ${answers.length - 2} more answers"),
                      ),
                    ),
                  );
                }

                // Only show the first 2 answers initially

                // Add spacing between question and answers groups
                questionAndAnswers.add(SizedBox(height: 7));
                questionAndAnswers.add(
                  Divider(
                    color: tgPrimaryText,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.4,
                  ),
                );
                questionAndAnswers.add(SizedBox(height: 10));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: questionAndAnswers,
                );
              },
            ),
          );
  }
}
