import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/welcome/widgets/header_details_widget.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/font_styles.dart';
import '../../../global_widgets/custom_rounded_button_with_icon.dart';

class WelcomePageCoulumn extends StatelessWidget {
  const WelcomePageCoulumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderDetails(comingFromWelcome: true),
        const SizedBox(
          height: 25,
        ),
        CustomRoundedButtonWithIcon(
          title: "Continuar con Google",
          onPressed: () => {},
          icon: googleIcon,
          splashColor: Colors.red,
          textColor: primaryColor,
          buttonColor: Colors.white,
        ),
        const SizedBox(
          height: 10,
        ),
         CustomRoundedButtonWithIcon(
          title: "Continuar con Email",
          onPressed: () => Navigator.pushNamed(context, Routes.login),
          icon: Icons.email,
          splashColor: Colors.red,
          textColor: primaryColor,
          buttonColor: Colors.white,
        ),
        const SizedBox(
          height: 8,
        ),
        MaterialButton(
          key: const Key("register_button"),
          onPressed: () => Navigator.pushNamed(context, Routes.register),
          child: Text(
            "Sign up",
            style: FontStyles.subtitle.copyWith(
              color: primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
