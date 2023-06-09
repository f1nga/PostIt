import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/routes/arguments.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/global_widgets/user_icon.dart';
import 'package:wallapop/src/ui/global_widgets/user_stars.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_post_detail/widgets/button_category.dart';
import 'package:wallapop/src/utils/colors.dart';

import '../../../../../../utils/methods.dart';
import '../post_detail_controller.dart';

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;
    final PostDetailController controller =
        context.watch<PostDetailController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "${post.price} €",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            post.state,
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          InkWell(
            child: Row(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 90,
                      child: UserIcon(
                        userNickname: controller.user!.nickname,
                        userColor: Colors.greenAccent,
                        width: 60,
                        height: 60,
                        fontSize: 30,
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      left: 14,
                      child: Container(
                        width: 35,
                        height: 27,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(30, 30)),
                          color: backgroundColor,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => controller
                                .onIsProfileLikePressed(controller.user!.id),
                            child: controller.isProfileLiked
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 22,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      controller.user!.nickname,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    UserStars(
                      stars: controller.user!.stars,
                      size: 18,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.poll_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            "${controller.user!.productsSolded.length} Ventas"),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                DefaultLineButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Routes.chat,
                    arguments: ChatArguments(
                      post: post,
                      user: controller.user!,
                    ),
                  ),
                  title: "Chat",
                  textColor: primaryColor,
                ),
              ],
            ),
            onTap: () => Navigator.pushNamed(
              context,
              Routes.profileResume,
              arguments: controller.user,
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          ButtonCategory(
            title: post.category,
            onPressed: () => {},
            icon: Methods.getCategoryIcon(post.category),
            width: 150,
            buttonColor: backgroundColor,
            textColor: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            post.description,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.getLastEditedDate(post.date.toDate())),
              const Spacer(),
              const Icon(Icons.remove_red_eye_outlined),
              const SizedBox(
                width: 8,
              ),
              Text(controller.postViews.toString()),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                child: controller.isLiked
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 25,
                      )
                    : const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                onTap: () => controller.onIsLikedPressed(post.id),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(controller.postLikes.toString()),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
