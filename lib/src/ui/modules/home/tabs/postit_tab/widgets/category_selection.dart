import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/models/utils/product_category_type.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/postit_controller.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';

///This widget is the filter button in the users tab, it opens a modal bottom sheet with the filter options
class CategorySelection extends StatefulWidget {
  const CategorySelection({super.key});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PostitController>(
      context,
      listen: true,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        const Icon(Icons.category, color: tertiaryColor),
        const SizedBox(
          width: 15,
        ),
        Text(
          controller.category == null
              ? "Categoría"
              : controller.category!.value,
          style: const TextStyle(
              color: Color.fromARGB(255, 128, 125, 125), fontSize: 16),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              color: tertiaryColor,
              onPressed: () => {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          height: 250,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 15),
                                    child: Text(
                                      "Categoría",
                                      style: FontStyles.bold
                                          .copyWith(fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                RadioListTile<int>(
                                  title: const Text(ProductCategoryType.cars),
                                  value: 1,
                                  groupValue: controller.isClickedCategory,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.onIsCarCategoryClicked(value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<int>(
                                  title:
                                      const Text(ProductCategoryType.computing),
                                  value: 2,
                                  groupValue: controller.isClickedCategory,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller
                                          .onIsComputingCategoryClicked(value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<int>(
                                  title: const Text(
                                      ProductCategoryType.homeAppliances),
                                  value: 3,
                                  groupValue: controller.isClickedCategory,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller
                                          .onIsHomeAppliancesCategoryClicked(
                                              value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              },
            ),
          ),
        ),
      ],
    );
  }
}
