import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wallapop/src/data/models/utils/product_category_type.dart';
import 'package:wallapop/src/utils/colors.dart';

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

  static IconData getCategoryIcon(String category) {
    switch (category) {
      case ProductCategoryType.cars:
        return ProductCategoryType.carsIcon;
      case ProductCategoryType.pcs:
        return ProductCategoryType.pcsIcon;
      case ProductCategoryType.homeAppliances:
        return ProductCategoryType.homeAppliancesIcon;
      case ProductCategoryType.mobiles:
        return ProductCategoryType.mobilesIcon;
      case ProductCategoryType.consoles:
        return ProductCategoryType.consolesIcon;
      case ProductCategoryType.motorcycles:
        return ProductCategoryType.motorcyclesIcon;
      case ProductCategoryType.realEstate:
        return ProductCategoryType.realEstateIcon;
      case ProductCategoryType.sports:
        return ProductCategoryType.sportsIcon;
      default:
        return Icons.category;
    }
  }

  static void showQuestionDialog(BuildContext context, String title,
      String content, String textPositiveAction, Function onPressed,
      {String textNegativeAction = "Cancelar"}) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        MaterialButton(
          child: Text(textNegativeAction),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        customFlatButton(textPositiveAction, primaryColor, onPressed)
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget customFlatButton(
      String title, Color bgColor, Function onPressed,
      [isIconButton = false,
      IconData icon = Icons.check_circle,
      Color textColor = Colors.white]) {
    return !isIconButton
        ? TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: onPressed as void Function()?,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          )
        : TextButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(bgColor)),
            onPressed: onPressed as void Function()?,
            icon: Icon(
              icon,
              color: textColor,
            ),
            label: Text(
              title,
              style: TextStyle(color: textColor),
            ));
  }

  static String formatDate(DateTime date) {
    late String month;
    if (date.month == 1) {
      month = "ene";
    } else if (date.month == 2) {
      month = "feb";
    } else if (date.month == 3) {
      month = "mar";
    } else if (date.month == 4) {
      month = "abr";
    } else if (date.month == 5) {
      month = "may";
    } else if (date.month == 6) {
      month = "jun";
    } else if (date.month == 7) {
      month = "jul";
    } else if (date.month == 8) {
      month = "ago";
    } else if (date.month == 9) {
      month = "set";
    } else if (date.month == 10) {
      month = "oct";
    } else if (date.month == 11) {
      month = "nov";
    } else if (date.month == 12) {
      month = "dic";
    }

    return "${date.day} $month ${date.year}";
  }

  static String formatDate2(DateTime date) {
    late String month;
    if (date.month == 1) {
      month = "ene";
    } else if (date.month == 2) {
      month = "feb";
    } else if (date.month == 3) {
      month = "mar";
    } else if (date.month == 4) {
      month = "abr";
    } else if (date.month == 5) {
      month = "may";
    } else if (date.month == 6) {
      month = "jun";
    } else if (date.month == 7) {
      month = "jul";
    } else if (date.month == 8) {
      month = "ago";
    } else if (date.month == 9) {
      month = "set";
    } else if (date.month == 10) {
      month = "oct";
    } else if (date.month == 11) {
      month = "nov";
    } else if (date.month == 12) {
      month = "dic";
    }

    return "${date.day} $month";
  }

  static Widget getIconState(File? imageFile) {
    if (imageFile == null) {
      return const Icon(
        Icons.image_search,
        color: secondaryColor,
        size: 32,
      );
    } else {
      return Image.file(
        imageFile,
        fit: BoxFit.fill,
      );
    }
  }

  static String getLastEditedDate(DateTime date) {
    final DateTime currentDate = Timestamp.now().toDate();

    if (date.year == currentDate.year && date.month == currentDate.month) {
      if (date.day == currentDate.day) {
        if (date.hour == currentDate.hour) {
          return "Editado hace ${currentDate.minute - date.minute} minutos";
        } else {
          return "Editado hace ${currentDate.hour - date.hour} horas";
        }
      } else {
        if (currentDate.day - date.day == 1) return "Editado ayer";
        for (var i = 2; i <= 6; i++) {
          if (currentDate.day - date.day == i) return "Editado hace $i días";
        }
        if (currentDate.day - date.day <= 13) {
          return "Editado hace más de una semana";
        }
        if (currentDate.day - date.day <= 20) {
          return "Editado hace más de dos semanas";
        }
        return "Hace menos de un mes";
      }
    }
    return "Editado hace más de un mes";
  }

  static Future<Digest> generateToken() async {
    Uuid uuid = const Uuid();
    List<int> bytes1 = utf8.encode(uuid.v1());

    return sha256.convert(bytes1);
  }
}
