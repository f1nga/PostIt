import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color textColor, backgroundColor, borderColor;
  final bool fullWidth;
  final EdgeInsets padding;
  final double fontSize;
  final IconData? iconData;
  final double? borderRadius;

  const RoundedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.iconData,
    this.textColor = textColorWhite,
    this.backgroundColor = primaryColor,
    this.borderColor = transparentColor,
    this.fullWidth = true,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 30,
    ),
    this.fontSize = 16,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: Border.all(color: borderColor, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: backgroundColor,
              blurRadius: 2,
            ),
          ],
        ),
        child: iconData != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: FontStyles.bold.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    iconData,
                    size: 24,
                    color: textColor,
                  ),
                ],
              )
            : Text(
                label,
                textAlign: TextAlign.center,
                style: FontStyles.bold.copyWith(
                  color: textColor,
                  fontSize: fontSize,
                ),
              ),
      ),
    );
  }
}
