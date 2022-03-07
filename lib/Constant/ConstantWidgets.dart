import 'package:flutter/cupertino.dart';
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

//'Successfully deleted.'
  static Future<void> cupertinoOkAlertDialog(
      BuildContext context, String title, String content) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
