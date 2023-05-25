// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/font_styles.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../routes/arguments.dart';
import '../../../../../../routes/routes.dart';

class ItemLastSearch extends StatelessWidget {
  final String search;
  final VoidCallback onLikePressed, onRemovePressed;
  final bool likedSearch;
  final Future<List<Post>> onSubmit;

  const ItemLastSearch({
    super.key,
    required this.search,
    required this.onLikePressed,
    required this.likedSearch,
    required this.onRemovePressed,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    void submit(String text) async {
      Navigator.pushNamed(
        context,
        Routes.postsFiltered,
        arguments: FilterPostsArguments(
          postsList: await onSubmit,
          searchText: search
        ),
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
                onPressed: onRemovePressed,
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
