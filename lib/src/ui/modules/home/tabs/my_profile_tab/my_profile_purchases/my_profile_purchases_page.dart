// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_purchases/widgets/my_profile_purchases_products.dart';

import '../../../../../../helpers/get.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';

class MyProfilePurchasesPage extends StatefulWidget {
  const MyProfilePurchasesPage({super.key});

  @override
  State<MyProfilePurchasesPage> createState() => _MyProfilePurchasesPageState();
}

class _MyProfilePurchasesPageState extends State<MyProfilePurchasesPage> {
  late final MyProfilePurchasesController controller;

  @override
  void initState() {
    controller = MyProfilePurchasesController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.afterFistLayout();
    });
    Get.i.put<MyProfilePurchasesController>(controller);
    controller.onDispose = () => Get.i.remove<MyProfilePurchasesController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProfilePurchasesController>(
      create: (_) => controller,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Compras",
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
              Navigator.pop(
                context,
              );
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MIS COMPRAS',
                    style: FontStyles.title.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const MyProfilePurchasesProducts(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
