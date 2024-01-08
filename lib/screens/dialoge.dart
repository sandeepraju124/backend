import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(context, description) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(elevation: 10,
      
        title: Text('Confirm Business'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              // Perform actions on location confirmation
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
