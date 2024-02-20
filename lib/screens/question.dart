// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_declarations, avoid_print, use_build_context_synchronously

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/screens/diaplayquestions.dart';
import 'package:flutter/Material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';

class Questionpage extends StatefulWidget {
  Questionpage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<Questionpage> createState() => _QuestionpageState();
}

class _QuestionpageState extends State<Questionpage> {
  final TextEditingController _questioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AskCommunityProvider>(context);
    return Scaffold(
        // backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(LineAwesomeIcons.angle_left),
            color: tgPrimaryText,
          ),
          backgroundColor: tgPrimaryColor,
          title: Text(
            'Questions',
            style: TextStyle(color: tgPrimaryText, fontSize: 15),
          ),
        ),
        body: ListView(children: [
          Column(
            children: [
              SizedBox(height: 17),

              SizedBox(
                width: 360,
                child: TextField(
                  style: TextStyle(color: secondaryColor40LightTheme),
                  controller: _questioncontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Type your question here",
                      hintStyle: TextStyle(
                        color: secondaryColor20LightTheme,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide.none,
                      )),
                  autofocus: false,
                  maxLines: null,
                ),
              ),

              SizedBox(height: 12),
              SizedBox(
                height: 40,
                width: 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: tgPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    data.PostAskcommunity(
                      context,
                      data.askCommunityData!.businessUid,
                      _questioncontroller.text,
                      // _questioncontroller
                    ).then((success) => {
                          if (success)
                            {
                              _questioncontroller.clear(),
                            }
                        });
                  },
                  child: Text(
                    "Post your Question",
                    style: TextStyle(color: tgPrimaryText),
                  ),
                ),
              ),
              SizedBox(height: 23),

              // if (data.askCommunityData!.data.isNotEmpty) ...[
              //   Padding(
              //     padding: const EdgeInsets.only(right: 190),
              //     child: Container(
              //       decoration: BoxDecoration(
              //           border:
              //               Border(bottom: BorderSide(color: tgPrimaryColor))),
              //       child: Text(
              //         "Below! All Previously asked Q&A.",
              //         style: TextStyle(fontSize: 13),
              //       ),
              //     ),
              //   ),
              // ],
              if (data.askCommunityData?.data.isNotEmpty ?? false) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 190),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: tgPrimaryColor))),
                    child: Text(
                      "Below! All Previously asked Q&A.",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],

              SizedBox(height: 7),

              Divider(
                color: tgPrimaryText,
                indent: 10,
                endIndent: 10,
                thickness: 0.1,
              ),

              ////////////////////// question UI starts from here ///////////

              displayQuestions(),
            ],
          ),
        ]));
  }
}
