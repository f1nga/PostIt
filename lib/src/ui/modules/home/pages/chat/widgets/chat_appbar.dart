// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/global_widgets/circle_user_image.dart';
import 'package:wallapop/src/ui/modules/home/pages/chat/chat_controller.dart';
import 'package:wallapop/src/utils/font_styles.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../data/models/user.dart';

class ChatAppbar extends StatelessWidget {
  final Post post;
  final User user;

  const ChatAppbar({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final ChatController controller = context.watch<ChatController>();

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.postDetail,
        arguments: post,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 20, top: 35),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  controller.closeStream();
                  Navigator.pushNamed(
                    context,
                    Routes.home,
                    arguments: 3,
                  );
                },
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  post.imagesList[0],
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${post.price} €",
                    style: FontStyles.title,
                  ),
                  Text(
                    post.title,
                    style: FontStyles.regular.copyWith(fontSize: 18),
                  ),
                ],
              ),
              const Spacer(),
              CircleUserImage(
                image: user.image,
                height: 50,
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
