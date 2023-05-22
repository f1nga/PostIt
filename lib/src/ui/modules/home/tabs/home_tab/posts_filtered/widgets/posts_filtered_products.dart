import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/global_widgets/item_post.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/posts_filtered/posts_filtered_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../global_widgets/animation.dart';

class PostsFilteredProducts extends StatelessWidget {
  const PostsFilteredProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final PostsFilteredController controller =
        context.watch<PostsFilteredController>();

    return controller.postsList.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10),
                itemCount: controller.postsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemPost(
                    post: controller.postsList[index],
                    comingFromMyProfile: false,
                    onLikePressed: () => controller.postFavouriteClicked(
                        controller.postsList[index].id, index),
                    likedPosts: controller.likedPosts[index],
                  );
                },
              ),
            ),
          )
        : const Padding(
            padding: EdgeInsets.only(top: 90),
            child: AnimationLottie(
              titleText: "No se ha encontrado nada",
              descText:
                  "Por ahora no hay resultados para tu búsqueda. ¿Has probado con otras palabras?",
              lottiePath: 'assets/animations/search_not_found.json',
              buttonText: "",
              lottieWidth: 200,
              lottieHeight: 200,
            ),
          );
  }
}
