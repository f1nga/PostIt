import 'package:flutter/material.dart';

import '../ui/global_widgets/rounded_button.dart';
import 'font_styles.dart';
import 'icons.dart';

abstract class Dialogs {
  static Future<void> alert(
    BuildContext context, {
    String? title,
    String? description,
    String okText = "OK",
    bool dismissible = true,
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => WillPopScope(
        onWillPop: () async => dismissible,
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title != null
                  ? Text(
                      title,
                      style: FontStyles.semiBold,
                    )
                  : Container(),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(closeIcon),
              ),
            ],
          ),
          content: description != null
              ? Text(
                  description,
                  style: FontStyles.regular,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: RoundedButton(
                key: const Key("confirm_button"),
                onPressed: () {
                  onPressed == null ? Navigator.pop(context) : onPressed();
                },
                label: okText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class ProgressDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
