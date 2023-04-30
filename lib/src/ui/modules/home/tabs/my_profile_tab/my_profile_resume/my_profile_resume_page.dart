import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/widgets/my_profile_resume_header.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_action.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_header.dart';

import '../../../../../../helpers/get.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';
import 'widgets/my_profile_resume_products.dart';

class MyProfileResumePage extends StatefulWidget {
  const MyProfileResumePage({super.key});

  @override
  State<MyProfileResumePage> createState() => _MyProfileResumePageState();
}

class _MyProfileResumePageState extends State<MyProfileResumePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProfileResumeController>(
      create: (_) {
        final MyProfileResumeController controller =
            MyProfileResumeController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout();
        });
        Get.i.put<MyProfileResumeController>(controller);
        controller.onDispose = () => Get.i.remove<MyProfileResumeController>();
        return controller;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            key: const Key("arrow_back_icon"),
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.home);
            },
          ),
        ),
        body: SafeArea(
          child: Column(children: const [
            MyProfileResumeHeader(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "MIS PRODUCTOS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyProfileResumeProducts()
          ]),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
