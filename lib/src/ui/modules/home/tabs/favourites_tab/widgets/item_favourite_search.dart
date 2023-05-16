import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/favourites_tab_controller.dart';

import '../../../../../../utils/font_styles.dart';
import 'package:provider/provider.dart';

class ItemFavouriteSearch extends StatelessWidget {
  final int index;

  const ItemFavouriteSearch({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final FavouritesTabController controller =
        context.watch<FavouritesTabController>();

    return InkWell(
      onTap: () async {
        Navigator.pushNamed(
          context,
          Routes.postsFiltered,
          arguments: await controller
              .onIsSearchClicked(controller.userSearches[index]),
        );
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.repeat,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: Text(
                controller.userSearches[index],
                style: FontStyles.title.copyWith(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () => controller.searchFavouriteClicked(
                  controller.userSearches[index], index),
              icon: controller.likedSearches[index]
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
