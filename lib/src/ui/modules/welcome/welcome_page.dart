import 'widgets/column_welcome_page_widget.dart';
import 'widgets/header_details_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //HeaderDetails(),
              WelcomePageCoulumn(),
            ],
          ),
        ),
      ),
    );
  }
}
