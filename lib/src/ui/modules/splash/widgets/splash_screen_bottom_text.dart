import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

class SplashScreenBottomText extends StatelessWidget {
  const SplashScreenBottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "From",
            style: FontStyles.semiBold.copyWith(
              color: tertiaryColor,
            ),
          ),
          Text(
            "PostIt",
            style: FontStyles.bold.copyWith(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
