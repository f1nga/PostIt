import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/home_tab_products.dart';

import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../data/models/utils/product_category_type.dart';
import '../../../../../data/models/utils/product_state_type.dart';
import '../../../../../helpers/get.dart';
import '../../../../../utils/font_styles.dart';
import '../my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTabController>(
      create: (_) {
        final HomeTabController controller = HomeTabController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout();
        });
        Get.i.put<HomeTabController>(controller);
        controller.onDispose = () => Get.i.remove<HomeTabController>();
        return controller;
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categorías populares',
                style: FontStyles.title.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: _buildCategoryCard('Ropa', Icons.accessibility_new,
                          Colors.blue, context),
                    ),
                    _buildCategoryCard(
                        'Electrónica', Icons.devices, Colors.orange, context),
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
