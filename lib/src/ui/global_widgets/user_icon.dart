import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class UserIcon extends StatelessWidget {
  final String userNickname;
  final Color? userColor;
  final double width, height, fontSize;

  const UserIcon({
    super.key,
    required this.userNickname,
    required this.userColor,
    required this.width,
    required this.height,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: userColor,
      ),
      child: Center(
        child: Text(
          userNickname[0].toUpperCase(),
          style: FontStyles.bold.copyWith(
            color: textColorWhite,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
