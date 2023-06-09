// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/global_widgets/item_post.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

import '../home_tab_controller.dart';

class HomeTabProducts extends StatelessWidget {
  const HomeTabProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeTabController controller = context.watch<HomeTabController>();

    return SingleChildScrollView(
      child: Container(
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
              onLikePressed: () => controller.postFavouriteClicked(
                  controller.userPosts[index].id, index),
              likedPosts: controller.likedPosts[index],
              comingFromMyProfile: false,
            );
          },
        ),
      ),
    );
  }
}
