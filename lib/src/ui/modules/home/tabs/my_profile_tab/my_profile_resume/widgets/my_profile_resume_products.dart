import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../../../data/models/user.dart';
import '../../../../../../global_widgets/item_post.dart';

class MyProfileResumeProducts extends StatelessWidget {
  const MyProfileResumeProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: backgroundColor,
        height: MediaQuery.of(context).size.height - 280,
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10),
          itemCount: controller.userPosts.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemPost(
              post: controller.userPosts[index],
              comingFromMyProfile: true,
            );
          },
        ),
      ),
    );
  }
}
