// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/routes/arguments.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/posts_filtered/widgets/posts_filtered_products.dart';

import '../../../../../../helpers/get.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/dialogs.dart';
import '../../../../../../utils/font_styles.dart';
import '../../../../../global_widgets/search_bar.dart';
import '../widgets/item_last_search.dart';
import 'posts_filtered_controller.dart';

class PostsFilteredPage extends StatefulWidget {
  const PostsFilteredPage({super.key});

  @override
  State<PostsFilteredPage> createState() => _PostsFilteredPageState();
}

class _PostsFilteredPageState extends State<PostsFilteredPage> {
  late final PostsFilteredController controller;

  @override
  void initState() {
    controller = PostsFilteredController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.afterFistLayout();
    });
    Get.i.put<PostsFilteredController>(controller);
    controller.onDispose = () => Get.i.remove<PostsFilteredController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FilterPostsArguments args =
        ModalRoute.of(context)!.settings.arguments as FilterPostsArguments;

    controller.setArguments(args);

    void submit(String text) async {
      if (await controller.addNewSearchToDB(text)) {
        Navigator.pushNamed(
          context,
          Routes.postsFiltered,
          arguments: FilterPostsArguments(
            postsList: await controller.submit(text),
            category: controller.filterCategory,
            searchText: text,
          ),
        );
      } else {
        Dialogs.alert(
          context,
          title: "Error",
          description: "No se ha podido buscar",
        );
      }
    }

    return ChangeNotifierProvider<PostsFilteredController>(
      create: (_) => controller,
      builder: (_, __) {
        final controller = Provider.of<PostsFilteredController>(
          _,
          listen: true,
        );
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Productos filtrados",
              style: FontStyles.title.copyWith(
                color: secondaryColor,
              ),
            ),
            centerTitle: false,
            leading: IconButton(
              key: const Key("arrow_back_icon"),
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, Routes.home);
              },
            ),
          ),
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SearchBar(
                            textFieldController: controller.textFieldController,
                            onPressed: () {
                              controller.textFieldController.clear();
                              controller.unFocusSearchBar();
                              setState(() {
                                controller.onIsSearchTextChanged("");
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                controller.onIsSearchTextChanged(value);
                              });
                            },
                            focusNode: controller.focusNode,
                            onSubmitted: (text) => submit(text),
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.searchFavouriteClicked(
                              args.searchText, null),
                          icon: controller.isSearchLiked
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 27,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  size: 27,
                                ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Builder(builder: (context) {
                      final bool isFocus =
                          context.select<PostsFilteredController, bool>(
                              (_) => _.focusNode.hasFocus);
                      return Visibility(
                        visible: !isFocus,
                        replacement: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Búsquedas recientes",
                                    style:
                                        FontStyles.title.copyWith(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      {controller.removeAllSearchesList()},
                                  icon: const Icon(
                                    Icons.highlight_remove,
                                    color: primaryColor,
                                  ),
                                )
                              ],
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.searchesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ItemLastSearch(
                                  search: controller.searchesList[index],
                                  onLikePressed: () =>
                                      controller.searchFavouriteClicked(
                                          controller.searchesList[index],
                                          index),
                                  likedSearch: controller.likedSearch[index],
                                  onRemovePressed: () =>
                                      controller.removeSearchToDB(
                                          controller.searchesList[index]),
                                  onSubmit: controller
                                      .submit(controller.searchesList[index]),
                                );
                              },
                            ),
                          ],
                        ),
                        child: const PostsFilteredProducts(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool get wantKeepAlive => true;
}
