import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/global_widgets/item_post.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/posts_filtered/posts_filtered_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../../utils/colors.dart';

class PostsFilteredProducts extends StatelessWidget {
  const PostsFilteredProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final PostsFilteredController controller =
        context.watch<PostsFilteredController>();

    return Container(
      color: backgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.postsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemPost(
            post: controller.postsList[index],
            comingFromMyProfile: true,
          );
        },
      ),
    );
  }
}
