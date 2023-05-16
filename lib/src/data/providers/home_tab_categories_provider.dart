import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/model/home_tab_category_model.dart';

class HomeTabCategoriesProvider {
  static List<HomeTabCategoryModel> getHomeTabCategoryList() {
    return [
      HomeTabCategoryModel(icon: Icons.abc, title: "sddas"),
      HomeTabCategoryModel(icon: Icons.abc, title: "sddas"),
      HomeTabCategoryModel(icon: Icons.abc, title: "sddas"),
    ];
  }
}
