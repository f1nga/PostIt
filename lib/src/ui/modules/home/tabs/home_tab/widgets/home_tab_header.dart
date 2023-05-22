// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/utils/product_category_type.dart';
import 'package:wallapop/src/routes/arguments.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/item_last_search.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/dialogs.dart';

import '../../../../../../utils/font_styles.dart';
import '../../../../../global_widgets/search_bar.dart';
import 'package:provider/provider.dart';

import 'home_tab_products.dart';

class HomeTabHeader extends StatefulWidget {
  const HomeTabHeader({super.key});

  @override
  State<HomeTabHeader> createState() => _HomeTabHeaderState();
}

class _HomeTabHeaderState extends State<HomeTabHeader> {
  @override
  Widget build(BuildContext context) {
    final HomeTabController controller = context.watch<HomeTabController>();

    void submit(String text) async {
      if (await controller.addNewSearchToDB(text)) {
        controller.unFocusSearchBar();

        Navigator.pushNamed(
          context,
          Routes.postsFiltered,
          arguments: FilterPostsArguments(
            postsList: await controller.submit(text),
            searchText: text
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

    void onCategoryClicked(String category) async {
      Navigator.pushNamed(
        context,
        Routes.postsFiltered,
        arguments: FilterPostsArguments(
          postsList: await controller.onCategoryClicked(category),
          category: category,
          searchText: ""
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
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
            Visibility(
              visible: !controller.focusNode.hasFocus,
              replacement: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Búsquedas recientes",
                          style: FontStyles.title.copyWith(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        onPressed: () => {controller.removeAllSearchesList()},
                        icon: const Icon(
                          Icons.highlight_remove,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.searchesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemLastSearch(
                        search: controller.searchesList[index],
                        onLikePressed: () => controller.searchFavouriteClicked(
                            controller.searchesList[index], index),
                        likedSearch: controller.likedSearch[index],
                        onRemovePressed: () => controller
                            .removeSearchToDB(controller.searchesList[index]),
                        onSubmit:
                            controller.submit(controller.searchesList[index]),
                      );
                    },
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => controller.focusNode.unfocus(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    ProductCategoryType.carsIcon,
                                    size: 30,
                                  ),
                                  onPressed: () => onCategoryClicked(
                                      ProductCategoryType.cars)),
                              const Text(ProductCategoryType.cars)
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  ProductCategoryType.pcsIcon,
                                  size: 30,
                                ),
                                onPressed: () =>
                                    onCategoryClicked(ProductCategoryType.pcs),
                              ),
                              const Text(ProductCategoryType.pcs)
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    ProductCategoryType.mobilesIcon,
                                    size: 30,
                                  ),
                                  onPressed: () => onCategoryClicked(
                                      ProductCategoryType.mobiles)),
                              const Text(ProductCategoryType.mobiles)
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    ProductCategoryType.consolesIcon,
                                    size: 30,
                                  ),
                                  onPressed: () => onCategoryClicked(
                                      ProductCategoryType.consoles)),
                              const Text(ProductCategoryType.consoles)
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    ProductCategoryType.motorcyclesIcon,
                                    size: 30,
                                  ),
                                  onPressed: () => onCategoryClicked(
                                      ProductCategoryType.motorcycles)),
                              const Text(ProductCategoryType.motorcycles)
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    ProductCategoryType.sportsIcon,
                                    size: 30,
                                  ),
                                  onPressed: () => onCategoryClicked(
                                      ProductCategoryType.sports)),
                              const Text(ProductCategoryType.sports)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Productos destacados',
                      style: FontStyles.title.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 20.0),
                    const HomeTabProducts()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      String title, IconData icon, Color color, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
