import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class CustomRoundedButtonWithIcon extends StatelessWidget {
  final double? radius;
  final Color? splashColor;
  final Color? textColor;
  final Color? buttonColor;
  final String title;
  final Function onPressed;
  final IconData icon;
  final double? width;
  const CustomRoundedButtonWithIcon({
    Key? key,
    this.radius,
    this.splashColor,
    this.textColor,
    this.buttonColor,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 50),
      onTap: onPressed as void Function()?,
      splashColor: splashColor ?? Colors.blue,
      child: Ink(
        width: width ?? 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 50),
            border: Border.all(color: Colors.black),
            color: buttonColor ?? Colors.blue,
            boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08))]),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: textColor ?? Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: FontStyles.subtitle.copyWith(
                    color: primaryColor,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
