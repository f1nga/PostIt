// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallapop/src/ui/global_widgets/circle_user_image.dart';
import 'package:wallapop/src/utils/colors.dart';

import '../../../../data/models/user.dart';
import '../../../../helpers/get.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/font_styles.dart';
import '../home_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.hideDrawer,
  });

  final VoidCallback hideDrawer;

  void _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.i.remove<User>();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.welcome,
      (route) => false,
    );
  }

  void _logoutAlertDialog(BuildContext context) {
    Dialogs.alert(
      context,
      title: "Cuidado",
      description: "Estás a punto de cerrar la sesión",
      okText: "OK",
      onPressed: () => _logout(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch<HomeController>();

    return Builder(builder: (context) {
      if (controller.currentUser != null) {
        return Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.popAndPushNamed(
                            context, Routes.home,
                            arguments: 3),
                        child: CircleUserImage(
                          image: controller.currentUser!.image,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.currentUser!.nickname,
                        style: FontStyles.title.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.currentUser!.email,
                        style:
                            FontStyles.subtitle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favoritos'),
                onTap: () => Navigator.popAndPushNamed(context, Routes.home,
                    arguments: 1),
              ),
              ListTile(
                leading: const Icon(Icons.post_add),
                title: const Text('Súbelo'),
                onTap: () => Navigator.popAndPushNamed(context, Routes.home,
                    arguments: 2),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Perfil'),
                onTap: () => Navigator.popAndPushNamed(context, Routes.home,
                    arguments: 3),
              ),
              const Divider(
                thickness: 1,
                color: tertiaryColor,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () => _logoutAlertDialog(context),
              ),
            ],
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
