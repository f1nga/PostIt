import 'package:flutter/material.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../global_widgets/item_post.dart';
import '../favourites_tab_controller.dart';

class FavouritesTabProducts extends StatelessWidget {
  const FavouritesTabProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final FavouritesTabController controller =
        context.watch<FavouritesTabController>();

    return SingleChildScrollView(
      child: Container(
        color: backgroundColor,
        height: MediaQuery.of(context).size.height,
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
