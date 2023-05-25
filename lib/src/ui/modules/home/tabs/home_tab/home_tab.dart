// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/home_tab_header.dart';

import '../../../../../helpers/get.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeTabController controller;

  @override
  void initState() {
    controller = HomeTabController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.afterFistLayout();
    });
    Get.i.put<HomeTabController>(controller);
    controller.onDispose = () => Get.i.remove<HomeTabController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTabController>(
      create: (_) => controller,
      child: const HomeTabHeader()
    );
  }
}