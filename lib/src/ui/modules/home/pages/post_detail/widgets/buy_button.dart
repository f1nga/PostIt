import 'package:flutter/material.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../global_widgets/rounded_button.dart';

class BuyButton extends StatefulWidget {
  final bool fullWidth;
  final double fontSize;
  final EdgeInsets padding;
  final VoidCallback onPressed;

  const BuyButton({
    super.key,
    this.fontSize = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
    this.fullWidth = true,
    required this.onPressed,
  });

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: RoundedButton(
        key: const Key("follow_button"),
        onPressed: widget.onPressed,
        backgroundColor: primaryColor,
        label: "Comprar",
        fullWidth: widget.fullWidth,
        fontSize: widget.fontSize,
        padding: widget.padding,
        iconData: Icons.shop,
      ),
    );
  }
}
