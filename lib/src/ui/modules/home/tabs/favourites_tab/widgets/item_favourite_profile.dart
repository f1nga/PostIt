import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/global_widgets/user_stars.dart';

class ItemFavouriteProfile extends StatelessWidget {
  final User user;
  final VoidCallback onLikePressed;
  final bool isClicked;

  const ItemFavouriteProfile({
    super.key,
    required this.user,
    required this.onLikePressed,
    required this.isClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.profileResume,
          arguments: user,
        );
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
                  image: NetworkImage(user.image),
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
                    user.nickname,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  UserStars(stars: user.stars, size: 20),
                ],
              ),
            ),
            IconButton(
              onPressed: onLikePressed,
              icon: isClicked
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
          ],
        ),
      ),
    );
  }
}
