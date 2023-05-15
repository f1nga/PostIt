import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/review.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/utils/font_styles.dart';
import 'package:wallapop/src/utils/methods.dart';

import '../../../../../../../data/models/user.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../global_widgets/user_icon.dart';
import '../../../../../../global_widgets/user_stars.dart';
import '../my_profile_resume_controller.dart';
import 'package:provider/provider.dart';

class ItemReview extends StatelessWidget {
  final Review review;

  const ItemReview({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.postDetail,
        arguments: controller.postReview,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 75,
            width: 80,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      controller.postReview.imagesList[0],
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ClipOval(
                    child: Image.network(
                      controller.userReview.image,
                      fit: BoxFit.cover,
                      height: 47,
                      width: 47,
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
                Text(
                  controller.comingFromMyProfile ? "Compraste" : "Vendió",
                  style: FontStyles.regular.copyWith(color: tertiaryColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.postReview.title,
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
                  "Por ${controller.userReview.nickname}",
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
    );
  }
}
