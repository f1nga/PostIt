import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class UserStars extends StatelessWidget {
  final int stars;
  final double size;
  final MainAxisAlignment mainAxisAlignment;

  const UserStars({
    super.key,
    required this.stars,
    required this.size,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          Icons.star,
          color: stars >= 1 ? Colors.amber : Colors.grey,
          size: size,
        ),
        Icon(
          Icons.star,
          size: size,
          color: stars >= 2 ? Colors.amber : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: size,
          color: stars >= 3 ? Colors.amber : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: size,
          color: stars >= 4 ? Colors.amber : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: size,
          color: stars >= 5 ? Colors.amber : Colors.grey,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "(${stars.toString()})",
          style: TextStyle(
            color: tertiaryColor,
            fontSize: size - 5,
          ),
        )
      ],
    );
  }
}
