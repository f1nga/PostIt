import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/widgets/home_tab_header.dart';

import '../../../../../helpers/get.dart';
import 'malbox_tab_controller.dart';

class MailboxTab extends StatefulWidget {
  const MailboxTab({super.key});

  @override
  State<MailboxTab> createState() => _MailboxTabState();
}

class _MailboxTabState extends State<MailboxTab> {
  late final MailboxTabController controller;

  @override
  void initState() {
    controller = MailboxTabController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.afterFistLayout();
    });
    Get.i.put<MailboxTabController>(controller);
    controller.onDispose = () => Get.i.remove<MailboxTabController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MailboxTabController>(
        create: (_) => controller,
        builder: (_, __) {
          final controller = Provider.of<MailboxTabController>(
            _,
            listen: true,
          );

          if (controller.currentUser != null) {
            return Container();
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
