import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/favourites_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/widgets/favourites_tab_header.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/widgets/item_favourite_profile.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/widgets/item_favourite_search.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/home_tab_products.dart';
import 'package:wallapop/src/utils/colors.dart';

import '../../../../../helpers/get.dart';
import '../../../../../utils/font_styles.dart';
import '../../../../global_widgets/item_post.dart';
import '../my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({super.key});

  @override
  State<FavouritesTab> createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavouritesTabController>(
      create: (_) {
        final FavouritesTabController controller = FavouritesTabController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout();
        });
        Get.i.put<FavouritesTabController>(controller);
        controller.onDispose = () => Get.i.remove<FavouritesTabController>();
        return controller;
      },
      builder: (_, __) {
        final controller = Provider.of<FavouritesTabController>(
          _,
          listen: true,
        );
        return Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const FavouritesTabHeader(),
              const SizedBox(
                height: 10,
              ),
              Builder(
                builder: (context) {
                  if (controller.isFavouritesProductsClicked) {
                    return ListView.separated(
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
                    );
                  } else if (controller.isFavouritesSearchesClicked) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                      itemCount: controller.userSearches.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemFavouriteSearch(
                          index: index,
                        );
                      },
                    );
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                      itemCount: controller.userProfiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemFavouriteProfile(
                          user: controller.userProfiles[index],
                          onLikePressed: () =>
                              controller.profileFavouriteClicked(index),
                          isClicked: controller.likedProfiles[index],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
