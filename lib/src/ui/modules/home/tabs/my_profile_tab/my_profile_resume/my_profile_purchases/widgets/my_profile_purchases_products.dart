import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../utils/colors.dart';
import '../../../../../../../global_widgets/item_post_finished.dart';

class MyProfilePurchasesProducts extends StatelessWidget {
  const MyProfilePurchasesProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfilePurchasesController controller =
        context.watch<MyProfilePurchasesController>();

    return Container(
      color: backgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.userPurchasedPosts.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemPostFinished(
            post: controller.userPurchasedPosts[index],
            userImage: controller.userCreatedPosts[index].image,
            comingFromMyProfile: true,
          );
        },
      ),
    );
  }
}
