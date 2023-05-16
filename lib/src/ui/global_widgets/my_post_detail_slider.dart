// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/pages/post_detail/post_detail_controller.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/dialogs.dart';
import 'package:wallapop/src/utils/methods.dart';

import '../../data/models/post.dart';
import '../modules/home/tabs/my_profile_tab/my_profile_resume/my_post_detail/my_post_detail_controller.dart';
import '../modules/home/tabs/my_profile_tab/my_profile_resume/my_post_detail/widgets/button_category.dart';

class MyPostDetailSlider extends StatefulWidget {
  final List<dynamic> images;
  final bool comingFromMyPost;
  final Post post;
  final bool likedProfile;

  const MyPostDetailSlider({
    super.key,
    required this.images,
    required this.comingFromMyPost,
    required this.post,
    this.likedProfile = false,
  });

  @override
  _MyPostDetailSliderState createState() => _MyPostDetailSliderState();
}

class _MyPostDetailSliderState extends State<MyPostDetailSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    PostDetailController? controller;
    MyPostDetailController? myPostDetailController;

    if (!widget.comingFromMyPost) {
      controller = context.watch<PostDetailController>();
    } else if (!widget.post.sold) {
      myPostDetailController = context.watch<MyPostDetailController>();
    }

    void deletePost() async {
      final bool postDeleted =
          await myPostDetailController!.deletePost(widget.post.id);

      if (postDeleted) {
        Navigator.popAndPushNamed(
          context,
          Routes.profileResume,
          arguments: await myPostDetailController.getCurrentUser(),
        );
        Methods.showSnackbar(context, "Producto eliminadao");
      } else {
        Dialogs.alert(
          context,
          title: "Cuidado",
          description: "No se ha podido borrar el producto",
        );
      }
    }

    void showQuestionDialog() {
      Methods.showQuestionDialog(
        context,
        "Cuidado",
        "Seguro que quieres borrar el post?",
        "Borrar",
        deletePost,
      );
    }

    return Container(
      height: 300,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.images.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 80,
                left: 20,
                child: widget.post.sold
                    ? ButtonCategory(
                        title: "Vendido",
                        icon: Icons.handshake,
                        onPressed: () {},
                        buttonColor: Colors.white,
                        textColor: primaryColor,
                        iconColor: primaryColor,
                      )
                    : const Text(""),
              ),
              Visibility(
                visible: !widget.comingFromMyPost && !widget.post.sold,
                child: Positioned(
                  top: 10,
                  right: 45,
                  child: controller != null
                      ? IconButton(
                          icon: controller.isLiked
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                          onPressed: () =>
                              controller!.onIsLikedPressed(widget.post.id),
                        )
                      : const Text(""),
                ),
              ),
              Positioned(
                right: 5,
                top: 10,
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  iconSize: 30,
                  onSelected: (String result) {
                    if (result == "opcion1") {
                      showQuestionDialog();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'opcion1',
                      child: const Text('Borrar producto'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        onPageChanged: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
