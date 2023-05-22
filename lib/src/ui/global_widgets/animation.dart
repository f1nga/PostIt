import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallapop/src/ui/global_widgets/rounded_button.dart';
import 'package:wallapop/src/utils/font_styles.dart';

class AnimationLottie extends StatelessWidget {
  final String titleText, descText, lottiePath, buttonText;
  final double? lottieHeight, lottieWidth;
  final VoidCallback? onPressed;

  const AnimationLottie({
    super.key,
    required this.titleText,
    required this.descText,
    required this.lottiePath,
    required this.buttonText,
    this.lottieHeight,
    this.lottieWidth,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(lottiePath, height: lottieHeight ?? 200, width: lottieWidth ?? 200),
        Text(
          titleText,
          style: FontStyles.title,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            descText,
            textAlign: TextAlign.center,
            style: FontStyles.medium,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: buttonText != "",
          child: RoundedButton(
            onPressed: onPressed ?? () {},
            label: buttonText,
            fullWidth: false,
          ),
        )
      ],
    );
  }
}
