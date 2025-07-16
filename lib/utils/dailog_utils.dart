import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Padding(padding: const EdgeInsets.all(8.0), child: Text(message)),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String title = "",
    String? posActionName,
    Function? posAction,
    String? negPosActionName,
    Function? negPosAction,
  }) {
    List<Widget>actions = [];
    if (posActionName != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        posAction?.call();
      }, child: Text(posActionName)));
    }
    if (negPosActionName != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        negPosAction?.call();
      }, child: Text(negPosActionName)));
    }
    showDialog(
      context: context,

      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          title: Text(title, style: Theme
              .of(context)
              .textTheme
              .titleMedium),
          actions: actions,

        );
      },
    );
  }
}
