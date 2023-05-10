import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/favourites_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/widgets/favourites_tab_products.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/home_tab_products.dart';

import '../../../../../helpers/get.dart';
import '../../../../../utils/font_styles.dart';
import '../my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({super.key});

  @override
  State<FavouritesTab> createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavouritesTabController>(
      create: (_) {
        final FavouritesTabController controller = FavouritesTabController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout();
        });
        Get.i.put<FavouritesTabController>(controller);
        controller.onDispose = () => Get.i.remove<FavouritesTabController>();
        return controller;
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MIS FAVORITOS',
                style: FontStyles.title.copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const FavouritesTabProducts()
            ],
          ),
        ),
      ),
    );
  }
}
