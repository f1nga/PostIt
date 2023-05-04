import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/favourites_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/widgets/favourites_tab_products.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/home_tab_products.dart';

import '../../../../../helpers/get.dart';
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
            children: const [
              Text(
                'Productos destacados',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              FavouritesTabProducts()
            ],
          ),
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

  Widget _buildProductCard(
      String title, String price, String imageUrl, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '$price',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
