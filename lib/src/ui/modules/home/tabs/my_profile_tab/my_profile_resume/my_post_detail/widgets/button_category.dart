import 'package:flutter/material.dart';

import '../../../../../../../../utils/colors.dart';
import '../../../../../../../../utils/font_styles.dart';

class ButtonCategory extends StatelessWidget {
  final double? radius;
  final Color? splashColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? buttonColor;
  final String title;
  final Function onPressed;
  final IconData icon;
  final double? width;
  const ButtonCategory({
    Key? key,
    this.radius,
    this.splashColor,
    this.iconColor,
    this.buttonColor,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.width,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 50),
      onTap: onPressed as void Function()?,
      splashColor: splashColor ?? Colors.blue,
      child: FittedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 50),
            color: buttonColor ?? Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: FontStyles.subtitle.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
