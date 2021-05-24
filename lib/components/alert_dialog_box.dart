import 'package:flutter/material.dart';

createAlertDialog(BuildContext context, String text, String toNavigateTo) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, toNavigateTo);
              },
              child: Text(
                'Okay',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      });
}
