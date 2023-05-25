import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/global_widgets/circle_user_image.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/font_styles.dart';
import 'package:wallapop/src/utils/methods.dart';

import '../../data/models/post.dart';
import '../../routes/routes.dart';

class ItemPostFinished extends StatelessWidget {
  final Post post;
  final String userImage;
  final bool comingFromMyProfile;

  const ItemPostFinished({
    super.key,
    required this.post,
    required this.comingFromMyProfile,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    void goToDetail(String route) {
      Navigator.pushNamed(
        context,
        route,
        arguments: post,
      );
    }

    return InkWell(
      onTap: () => comingFromMyProfile
          ? goToDetail(Routes.postDetail)
          : goToDetail(Routes.myPostDetail),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(post.imagesList[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleUserImage(
                      image: userImage,
                      height: 30,
                      width: 30,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                  ),
                ]),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        Methods.formatDate(post.date.toDate()),
                        style:
                            FontStyles.regular.copyWith(color: tertiaryColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${post.price} €",
                  style: FontStyles.title,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 1.0,
              color: tertiaryColor,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
