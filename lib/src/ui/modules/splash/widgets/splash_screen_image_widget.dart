import 'package:flutter/material.dart';

class SplashScreenImage extends StatelessWidget {
  const SplashScreenImage({super.key});
  final String splashImagePath = "assets/logo.png";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              splashImagePath,
              width: 90,
              height: 90,
            ),
          ),
        ],
      ),
    );
  }
}
