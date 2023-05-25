// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/review.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/utils/font_styles.dart';
import 'package:wallapop/src/utils/methods.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../global_widgets/user_stars.dart';
import '../my_profile_resume_controller.dart';
import 'package:provider/provider.dart';

class ItemReview extends StatelessWidget {
  final Review review;
  final int index;

  const ItemReview({
    super.key,
    required this.review,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.postDetail,
        arguments: controller.postReview[index],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 75,
                width: 80,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        controller.postReview[index].imagesList[0],
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.profileResume,
                          arguments: controller.userPost[index].nickname ==
                                  controller.user.nickname
                              ? controller.userReview[index]
                              : controller.userPost[index],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            controller.userPost[index].nickname ==
                                    controller.user.nickname
                                ? controller.userReview[index].image
                                : controller.userPost[index].image,
                            fit: BoxFit.cover,
                            height: 47,
                            width: 47,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.comingFromMyProfile)
                      Text(
                        controller.userPost[index].nickname ==
                                controller.user.nickname
                            ? "Vendiste"
                            : "Compraste",
                        style:
                            FontStyles.regular.copyWith(color: tertiaryColor),
                      ),
                    if (!controller.comingFromMyProfile)
                      Text(
                        controller.userPost[index].nickname ==
                                controller.user.nickname
                            ? "Vendió"
                            : "Compró",
                        style:
                            FontStyles.regular.copyWith(color: tertiaryColor),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.postReview[index].title,
                      style: FontStyles.title.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(review.description),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Por ${controller.userReview[index].nickname}",
                      style: FontStyles.regular.copyWith(color: tertiaryColor),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  UserStars(
                    stars: review.stars,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    Methods.formatDate(review.date.toDate()),
                    style: FontStyles.regular
                        .copyWith(color: tertiaryColor, fontSize: 16),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1,
            color: tertiaryColor,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
