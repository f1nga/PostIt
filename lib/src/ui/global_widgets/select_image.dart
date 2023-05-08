import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class SelectImage extends StatelessWidget {
  final Widget circleImage;
  final VoidCallback onPressed;
  final double width, height;
  const SelectImage({
    super.key,
    required this.circleImage,
    required this.onPressed,
    this.width = 85,
    this.height = 85,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tertiaryColor.withOpacity(0.5),
        ),
        width: width,
        height: height,
        child: ClipOval(
          child: circleImage,
        ),
      ),
    );
  }
}
