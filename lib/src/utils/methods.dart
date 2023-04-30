import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class Methods {
    // Generates and returns a unique identifier using the Uuid package.
  static String generateId() {
    Uuid uuid = const Uuid();
    return uuid.v4();
  }

  static void showSnackbar(BuildContext context, String title) {
  final snackBar = SnackBar(
    content: Text(
      title,
      textAlign: TextAlign.center,
    ),
    backgroundColor: const Color.fromARGB(255, 247, 60, 60),
    duration: const Duration(milliseconds: 1800),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
}
