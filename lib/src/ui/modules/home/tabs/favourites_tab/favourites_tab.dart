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
import '../../../../../routes/routes.dart';
import '../../../../../utils/font_styles.dart';
import '../../../../global_widgets/animation.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              const FavouritesTabHeader(),
              const SizedBox(
                height: 10,
              ),
              Builder(
                builder: (context) {
                  if (controller.isFavouritesProductsClicked) {
                    return controller.userPosts.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 10),
                            itemCount: controller.userPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemPost(
                                post: controller.userPosts[index],
                                onLikePressed: () =>
                                    controller.postFavouriteClicked(
                                        controller.userPosts[index].id, index),
                                likedPosts: controller.likedPosts[index],
                                comingFromMyProfile: false,
                              );
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: AnimationLottie(
                              titleText: "Productos que te gustan",
                              descText:
                                  "Para guardar un producto, pulsa el icono de producto favorito (❤️)",
                              lottiePath: 'assets/animations/favourite.json',
                              buttonText: "Buscar en PostIt",
                              onPressed: () => Navigator.popAndPushNamed(
                                context,
                                Routes.home,
                              ),
                            ),
                          );
                  } else if (controller.isFavouritesSearchesClicked) {
                    return controller.userSearches.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 10),
                            itemCount: controller.userSearches.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemFavouriteSearch(
                                index: index,
                              );
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: AnimationLottie(
                              titleText: "Cosas que quieres encontrar",
                              descText:
                                  "Para guardar una búsqueda, pulsa el icono de búsqueda favorita (❤️)",
                              lottiePath: 'assets/animations/search.json',
                              buttonText: "Buscar en PostIt",
                              lottieHeight: 250,
                              lottieWidth: 250,
                              onPressed: () => Navigator.popAndPushNamed(
                                context,
                                Routes.home,
                              ),
                            ),
                          );
                  } else {
                    return controller.userProfiles.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
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
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: AnimationLottie(
                              titleText: "Personas que te interesan",
                              descText:
                                  "Para guardar un perfil de usuario, pulsa el icono de perfil favorito (❤️)",
                              lottiePath: 'assets/animations/profile.json',
                              buttonText: "",
                              lottieHeight: 250,
                              lottieWidth: 250,
                             
                            ),
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
