import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_header.dart';

import '../../../../../helpers/get.dart';
import '../../../../../utils/colors.dart';

class MyProfileTab extends StatefulWidget {
  const MyProfileTab({super.key});

  @override
  State<MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<MyProfileTab> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProfileController>(
      create: (_) {
        final MyProfileController controller = MyProfileController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout();
        });
        Get.i.put<MyProfileController>(controller);
        controller.onDispose = () => Get.i.remove<MyProfileController>();
        return controller;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: const MyProfileHeader(),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
