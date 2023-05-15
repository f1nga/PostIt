import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/global_widgets/item_post_finished.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_purchases/widgets/my_profile_purchases_products.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_sales/my_profile_sales_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_sales/widgets/my_profile_sales_products.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_action.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_header.dart';

import '../../../../../../../helpers/get.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/font_styles.dart';

class MyProfileSalesPage extends StatefulWidget {
  const MyProfileSalesPage({super.key});

  @override
  State<MyProfileSalesPage> createState() => _MyProfileSalesPageState();
}

class _MyProfileSalesPageState extends State<MyProfileSalesPage> {
  late final MyProfileSalesController controller;

  @override
  void initState() {
    controller = MyProfileSalesController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.afterFistLayout();
    });
    Get.i.put<MyProfileSalesController>(controller);
    controller.onDispose = () => Get.i.remove<MyProfileSalesController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProfileSalesController>(
      create: (_) => controller,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Ventas",
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
                    'MIS VENTAS',
                    style: FontStyles.title.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const MyProfileSalesProducts(),
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
