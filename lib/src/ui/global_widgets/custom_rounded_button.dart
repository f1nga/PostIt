import 'package:flutter/material.dart';

import '../../utils/font_styles.dart';

class CustomRoundedButton extends StatelessWidget {
  final double? radius;
  final Color? splashColor;
  final Color? textColor;
  final Color? buttonColor;
  final String title;
  final Function onPressed;
  const CustomRoundedButton({
    Key? key,
    this.radius,
    this.splashColor,
    this.textColor,
    this.buttonColor,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(radius ?? 50),
        onTap: onPressed as void Function()?,
        splashColor: splashColor ?? Colors.blue,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 50),
            color: buttonColor ?? Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: FontStyles.subtitle.copyWith(
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
