import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Row(
          children: [
            Text("Loading...."),
            Spacer(),
            CircularProgressIndicator(),
          ],
        ),
      );
    },
  );
}

void showMessage(
  BuildContext context,
  String message, {
  String? title,
  String? posText,
  Function? onPosClick,
  String? negText,
  Function? onNegClick,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          if (negText != null)
            ElevatedButton(
              onPressed: () {
                onNegClick?.call();
              },
              child: Text(negText),
            ),
          if (posText != null)
            ElevatedButton(
              onPressed: () {
                onPosClick?.call();
              },
              child: Text(posText),
            ),
        ],
      );
    },
  );
}
