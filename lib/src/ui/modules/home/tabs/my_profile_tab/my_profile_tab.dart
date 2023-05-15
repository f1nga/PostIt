import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_action.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_header.dart';

import '../../../../../helpers/get.dart';
import '../../../../../utils/colors.dart';

class MyProfileTab extends StatefulWidget {
  const MyProfileTab({super.key});

  @override
  State<MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<MyProfileTab> {
  late final MyProfileController _controller;

  @override
  void initState() {
    _controller = MyProfileController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.afterFistLayout();
    });
    Get.i.put<MyProfileController>(_controller);
    _controller.onDispose = () => Get.i.remove<MyProfileController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProfileController>(
      create: (_) => _controller,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Consumer<MyProfileController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        const MyProfileHeader(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "TRANSACCIONES",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyProfileAction(
                          icon: const Icon(Icons.handshake),
                          title: "Compras",
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.myProfilePurchases,
                          ),
                        ),
                        MyProfileAction(
                          icon: const Icon(Icons.sell),
                          title: "Ventas",
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.myProfileSales,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Cuenta",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyProfileAction(
                          icon: const Icon(Icons.edit),
                          title: "Editar el perfil",
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.myProfilePurchases,
                          ),
                        ),
                      ],
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

  bool get wantKeepAlive => true;
}
