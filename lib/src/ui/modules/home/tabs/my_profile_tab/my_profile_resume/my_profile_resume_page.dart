import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/widgets/my_profile_resume_header.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/widgets/profile_resume_reviews.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/widgets/select_container.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_action.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_header.dart';

import '../../../../../../data/models/user.dart';
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
  late final MyProfileResumeController _controller;

  @override
  void initState() {
    _controller = MyProfileResumeController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.afterFistLayout();
    });
    Get.i.put<MyProfileResumeController>(_controller);
    _controller.onDispose = () => Get.i.remove<MyProfileResumeController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    _controller.setUser(user);

    return ChangeNotifierProvider<MyProfileResumeController>(
      create: (_) => _controller,
      child: Consumer<MyProfileResumeController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return Container(
              color: backgroundColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Resumen del perfil",
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
                  child: Column(
                    children: [
                      const MyProfileResumeHeader(),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      const SelectContainer(),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<MyProfileResumeController>(
                        builder: (context, controller, child) {
                          if (controller.selectedContainer == 1) {
                            return const MyProfileResumeProducts();
                          } else if (controller.selectedContainer == 2) {
                            return const ProfileResumeReviews();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Información básica",
                                    style: FontStyles.title,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        controller.user.nickname,
                                        style: FontStyles.regular
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.cake,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "23/64/2344",
                                        style: FontStyles.regular
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.description,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        controller.user.description,
                                        style: FontStyles.regular
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  bool get wantKeepAlive => true;
}
