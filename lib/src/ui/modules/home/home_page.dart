// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/favourites_tab.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_tab.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/postit_tab.dart';

import '../../../helpers/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import 'home_controller.dart';
import 'tabs/home_tab/home_tab.dart';
import 'widgets/drawer_widget.dart';
import 'widgets/home_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String clientIconPath = "assets/logo.png";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as Arguments;

    return ChangeNotifierProvider<HomeController>(
      create: (_) {
        final HomeController controller = HomeController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout();
        });
        Get.i.put<HomeController>(controller);
        controller.onDispose = () => Get.i.remove<HomeController>();
        return controller;
      },
      builder: (_, __) {
        final HomeController controller =
            Provider.of<HomeController>(_, listen: false);
        // final sessionToken = _.select<HomeController, bool>((_) => _.userToken);

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: backgroundColor,
          endDrawer: CustomDrawer(
            hideDrawer: () => _scaffoldKey.currentState!.closeEndDrawer(),
          ),
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => controller.tabController.index = 0,
                  child: ClipOval(
                    child: Image.asset(
                      clientIconPath,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Post It",
                  style: FontStyles.title.copyWith(
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            centerTitle: false,
            elevation: 0,
            actions: [
              IconButton(
                key: const Key("drawer_button"),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: const Icon(Icons.menu),
              )
            ],
          ),
          bottomNavigationBar: const HomeBottomBar(),
          body: SafeArea(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                HomeTab(),
                FavouritesTab(),
                PostitTab(),
                MyProfileTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
