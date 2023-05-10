import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CircleUserImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxBorder? border;

  const CircleUserImage({
    super.key,
    required this.image,
    this.height = 90,
    this.width = 90,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tertiaryColor.withOpacity(0.5),
        border: border,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipOval(
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: 140,
              width: 140,
            ),
          ),
        ],
      ),
    );
  }
}
