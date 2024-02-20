// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, use_super_parameters

import 'package:backendapp/provider/askcommunityprovider.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAnswerBottomSheet extends StatefulWidget {
  final String businessUid;
  final String questionId;
  final String answerId;
  final String currentAnswerText;

  const EditAnswerBottomSheet({
    Key? key,
    required this.businessUid,
    required this.questionId,
    required this.answerId,
    required this.currentAnswerText,
  }) : super(key: key);

  @override
  State<EditAnswerBottomSheet> createState() => _EditAnswerBottomSheetState();
}

class _EditAnswerBottomSheetState extends State<EditAnswerBottomSheet> {
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _answerController = TextEditingController(text: widget.currentAnswerText);
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AskCommunityProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, right: 244, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: tgDarkPrimaryColor))),
                  child: Text(
                    "Edit your Answer",
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 366,
              child: TextField(
                style: TextStyle(
                    color: secondaryColor40LightTheme, fontSize: 13.2),
                controller: _answerController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: "Kindly type your Answer here",
                  hintStyle: TextStyle(
                    color: secondaryColor20LightTheme,
                    fontSize: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17),
                    borderSide: BorderSide.none,
                  ),
                ),
                autofocus: false,
                maxLines: null,
              ),
            ),
          ),
          SizedBox(height: 12),
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
                    .editAnswer(
                        context,
                        data.askCommunityData!.businessUid,
                        widget.questionId,
                        widget.answerId,
                        _answerController.text)
                    .then((success) => {
                          if (success)
                            {
                              _answerController.clear(),
                              Navigator.pop(context),
                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Failed to edit your Answer.")),
                              )
                            }
                        });
              },
              child: Text(
                "Save Changes",
                style: TextStyle(color: tgPrimaryText),
              ),
            ),
          ),
          SizedBox(height: 33),
        ],
      ),
    );
  }
}
