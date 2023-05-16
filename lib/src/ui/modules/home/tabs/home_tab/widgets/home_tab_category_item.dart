import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/model/home_tab_category_model.dart';

class HomeTabCategoryItem extends StatelessWidget {
  final HomeTabCategoryModel model;

  const HomeTabCategoryItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(model.icon), Text(model.title)],
    );
  }
}
