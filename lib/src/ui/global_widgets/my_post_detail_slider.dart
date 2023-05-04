import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/pages/post_detail/post_detail_controller.dart';
import 'package:provider/provider.dart';

import '../../data/models/post.dart';

class MyPostDetailSlider extends StatefulWidget {
  final List<String> images;
  final bool comingFromMyPost;
  final Post post;

  const MyPostDetailSlider(
      {super.key,
      required this.images,
      required this.comingFromMyPost,
      required this.post});

  @override
  _MyPostDetailSliderState createState() => _MyPostDetailSliderState();
}

class _MyPostDetailSliderState extends State<MyPostDetailSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    PostDetailController? controller;

    if (!widget.comingFromMyPost) {
      controller = context.watch<PostDetailController>();
    }

    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: widget.images.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(children: [
            Image.network(
              widget.images[index],
              fit: BoxFit.cover,
              width: double.infinity,
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
                onPressed: () =>
                    Navigator.popAndPushNamed(context, Routes.home),
              ),
            ),
            Visibility(
              visible: !widget.comingFromMyPost,
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
                    : const Icon(
                        Icons.favorite_outline,
                        size: 0,
                      ),
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: PopupMenuButton<String>(
                color: Colors.white,
                iconSize: 30,
                onSelected: (String result) {
                  print(result);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'opcion1',
                    child: Text('Opción 1'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'opcion2',
                    child: Text('Opción 2'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'opcion3',
                    child: Text('Opción 3'),
                  ),
                ],
              ),
            ),
          ]);
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
