// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/font_styles.dart';
import 'package:wallapop/src/utils/icons.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/dialogs.dart';
import '../home_tab_controller.dart';

class ItemLastSearch extends StatelessWidget {
  final String search;
  final VoidCallback onLikePressed;
  final bool likedSearch;

  const ItemLastSearch({
    super.key,
    required this.search,
    required this.onLikePressed,
    required this.likedSearch,
  });

  @override
  Widget build(BuildContext context) {
    final HomeTabController controller = context.watch<HomeTabController>();

    void submit(String text) async {
      Navigator.pushNamed(
        context,
        Routes.postsFiltered,
        arguments: await controller.submit(text),
      );
    }

    return InkWell(
      onTap: () => submit(search),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: likedSearch
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
                onPressed: onLikePressed,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  search,
                  style: FontStyles.regular.copyWith(fontSize: 16),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => controller.removeSearchToDB(search),
              ),
            ],
          ),
          const Divider(
            thickness: 1.0,
            color: tertiaryColor,
          ),
        ],
      ),
    );
  }
}
