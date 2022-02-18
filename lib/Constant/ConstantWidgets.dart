import 'package:flutter/material.dart';

class ConstantWidgets {
  static void showMaterialDialog(
      BuildContext context, String txt, String title) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(txt),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }
}
