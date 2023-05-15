import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/widgets/item_review.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../../../data/models/user.dart';
import '../../../../../../global_widgets/item_post.dart';

class ProfileResumeReviews extends StatelessWidget {
  const ProfileResumeReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return SingleChildScrollView(
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
    );
  }
}
