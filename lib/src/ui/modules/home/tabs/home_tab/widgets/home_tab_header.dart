import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';

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

    void submit(String text) {
      controller.submit(text);
      Navigator.pushNamed(
        context,
        Routes.postsFiltered,
        arguments: controller.filteredPostsList,
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
            const SizedBox(height: 20.0),
            Visibility(
              visible: !controller.focusNode.hasFocus,
              replacement: GestureDetector(
                onTap: () => controller.unFocusSearchBar(),
                child: const SizedBox(
                  height: 550,
                  width: 500,
                  child: Text("dasdssa"),
                ),
              ),
              child: GestureDetector(
                onTap: () => controller.focusNode.unfocus(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: _buildCategoryCard('Ropa',
                                Icons.accessibility_new, Colors.blue, context),
                          ),
                          _buildCategoryCard('Electrónica', Icons.devices,
                              Colors.orange, context),
                          _buildCategoryCard(
                              'Hogar', Icons.home, Colors.pink, context),
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
