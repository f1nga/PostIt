import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/widgets/item_review.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../../global_widgets/animation.dart';

class ProfileResumeReviews extends StatelessWidget {
  const ProfileResumeReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return controller.userReviews.isNotEmpty ? SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        color: backgroundColor,
        height: MediaQuery.of(context).size.height - 280,
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10),
          itemCount: controller.userReviews.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemReview(
              review: controller.userReviews[index],
              index: index,
            );
          },
        ),
      ),
    ) : const AnimationLottie(
            titleText: "Nadie ha opinado todavía",
            descText:
                "Después de una transacción pide que te valoren. Las opiniones inspiran confianza.",
            lottiePath: 'assets/animations/review.json',
            buttonText: "",
            lottieWidth: 250,
            lottieHeight: 250,
          );
  }
}
