import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

class HeaderDetails extends StatelessWidget {
  final String imagePath = "assets/logo.png";
  final bool comingFromWelcome;

  const HeaderDetails({super.key, required this.comingFromWelcome});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(height: comingFromWelcome ? 300 : 150, width: comingFromWelcome ? 300 : 150, imagePath),
        Text(
          "Compra, vende productos, busca lo que más te gusta, diviértete!",
          style: FontStyles.subtitle.copyWith(
            fontSize: comingFromWelcome ? 20 : 15,
            color: tertiaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ]
    );
  }
}
