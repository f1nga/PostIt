// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/font_styles.dart';

class SelectContainer extends StatelessWidget {
  const SelectContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor,
                    width: controller.selectedContainer == 1 ? 1.5 : 0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    controller.userPosts.length.toString(),
                    style: FontStyles.title.copyWith(
                      fontSize: 20,
                      color: controller.selectedContainer == 1
                          ? Colors.black
                          : tertiaryColor,
                    ),  
                  ),
                  Text(
                    "En venta",
                    style: FontStyles.regular.copyWith(
                      color: controller.selectedContainer == 1
                          ? Colors.black
                          : tertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => controller.onisContainerSelected(1),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor,
                    width: controller.selectedContainer == 2 ? 1.5 : 0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    controller.userReviews.length.toString(),
                    style: FontStyles.title.copyWith(
                      fontSize: 20,
                      color: controller.selectedContainer == 2
                          ? Colors.black
                          : tertiaryColor,
                    ),
                  ),
                  Text(
                    "Valoraciones",
                    style: FontStyles.regular.copyWith(
                      color: controller.selectedContainer == 2
                          ? Colors.black
                          : tertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => controller.onisContainerSelected(2),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor,
                    width: controller.selectedContainer == 3 ? 1.5 : 0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "+",
                    style: FontStyles.title.copyWith(
                      fontSize: 20,
                      color: controller.selectedContainer == 3
                          ? Colors.black
                          : tertiaryColor,
                    ),
                  ),
                  Text(
                    "Info",
                    style: FontStyles.regular.copyWith(
                      color: controller.selectedContainer == 3
                          ? Colors.black
                          : tertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => controller.onisContainerSelected(3),
          ),
        ),
      ],
    );
  }
}
