// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/pages/purchase_review/purchase_review_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';

class SelectStars extends StatelessWidget {
  const SelectStars({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseReviewController controller =
        context.watch<PurchaseReviewController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.star,
            color: controller.clickedStars >= 1 ? Colors.amber : Colors.grey,
            size: 30,
          ),
          onPressed: () => controller.onIsStarsClicked(1),
        ),
        IconButton(
          icon: Icon(
            Icons.star,
            color: controller.clickedStars >= 2 ? Colors.amber : Colors.grey,
            size: 30,
          ),
          onPressed: () => controller.onIsStarsClicked(2),
        ),
        IconButton(
          icon: Icon(
            Icons.star,
            color: controller.clickedStars >= 3 ? Colors.amber : Colors.grey,
            size: 30,
          ),
          onPressed: () => controller.onIsStarsClicked(3),
        ),
        IconButton(
          icon: Icon(
            Icons.star,
            color: controller.clickedStars >= 4 ? Colors.amber : Colors.grey,
            size: 30,
          ),
          onPressed: () => controller.onIsStarsClicked(4),
        ),
        IconButton(
          icon: Icon(
            Icons.star,
            color: controller.clickedStars >= 5 ? Colors.amber : Colors.grey,
            size: 30,
          ),
          onPressed: () => controller.onIsStarsClicked(5),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "(${controller.clickedStars})",
          style: const TextStyle(
            color: tertiaryColor,
            fontSize: 30 - 5,
          ),
        )
      ],
    );
  }
}
