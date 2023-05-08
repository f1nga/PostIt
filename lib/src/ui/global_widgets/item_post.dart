import 'package:flutter/material.dart';

import '../../data/models/post.dart';
import '../../routes/routes.dart';

class ItemPost extends StatelessWidget {
  final Post post;
  final void Function()? onLikePressed;
  final bool? likedPosts;
  final bool comingFromMyProfile;

  const ItemPost({
    super.key,
    required this.post,
    this.onLikePressed,
    this.likedPosts,
    required this.comingFromMyProfile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (comingFromMyProfile) {
          Navigator.pushNamed(
            context,
            Routes.myPostDetail,
            arguments: post,
          );
        } else {
          Navigator.pushNamed(
            context,
            Routes.postDetail,
            arguments: post,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(post.imagesList[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${post.price} €",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !comingFromMyProfile,
              child: IconButton(
                onPressed: () {
                  print("adadsa");
                  onLikePressed!();
                },
                icon: likedPosts ?? false
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                        size: 30,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
