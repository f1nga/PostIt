// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/utils/product_category_type.dart';
import 'package:wallapop/src/data/providers/home_tab_categories_provider.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/home_tab_category_item.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/item_last_search.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/dialogs.dart';
import 'package:wallapop/src/utils/icons.dart';

import '../../../../../../data/models/post.dart';
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
        Navigator.pushNamed(
          context,
          Routes.postsFiltered,
          arguments: await controller.submit(text),
        );
      } else {
        Dialogs.alert(
          context,
          title: "Error",
          description: "No se ha podido buscar",
        );
      }
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
                    shrinkWrap: true,
                    itemCount: controller.searchesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemLastSearch(
                        search: controller.searchesList[index],
                        onLikePressed: () => controller.searchFavouriteClicked(
                            controller.searchesList[index], index),
                        likedSearch: controller.likedSearch[index],
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
                      height: 20.0,
                    ),
                    // ListView.builder(
                    //   scrollDirection: Axis.horizontal,
                    //   shrinkWrap: true,
                    //   itemCount:
                    //       HomeTabCategoriesProvider.getHomeTabCategoryList()
                    //           .length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return HomeTabCategoryItem(
                    //       model: HomeTabCategoriesProvider
                    //           .getHomeTabCategoryList()[index],
                    //     );
                    //   },
                    // ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              Icon(
                                ProductCategoryType.carsIcon,
                                size: 30,
                              ),
                              Text("Coches")
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
                              Icon(
                                ProductCategoryType.pcsIcon,
                                size: 30,
                              ),
                              Text("Ordenadores")
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
                              Icon(
                                ProductCategoryType.mobilesIcon,
                                size: 30,
                              ),
                              Text("Móviles")
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
                              Icon(
                                ProductCategoryType.consolesIcon,
                                size: 30,
                              ),
                              Text("Consolas")
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
                              Icon(
                                ProductCategoryType.motorcyclesIcon,
                                size: 30,
                              ),
                              Text("Motos")
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
                              Icon(ProductCategoryType.sportsIcon),
                              Text("Deportes")
                            ],
                          ),
                        ],
                      ),
                    )
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       GestureDetector(
                    //         child: _buildCategoryCard('Ropa',
                    //             Icons.accessibility_new, Colors.blue, context),
                    //       ),
                    //       _buildCategoryCard('Electrónica', Icons.devices,
                    //           Colors.orange, context),
                    //       _buildCategoryCard(
                    //           'Hogar', Icons.home, Colors.pink, context),
                    //     ],
                    //   ),
                    // ),
                    ,
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
