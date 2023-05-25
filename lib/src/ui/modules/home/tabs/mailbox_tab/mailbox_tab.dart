// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/global_widgets/animation.dart';
import 'package:wallapop/src/ui/modules/home/tabs/mailbox_tab/widgets/item_chat.dart';

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

          if (!controller.isLoading) {
            if (controller.chatsList.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10),
                itemCount: controller.chatsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemChat(
                    index: index,
                  );
                },
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(top:100),
                child: AnimationLottie(
                  titleText: "Todavía no tienes ningún chat",
                  descText:
                      "Habla e interactua, negocia con gente para vender o comprar productos que desees, a que esperas?",
                  lottiePath: 'assets/animations/chat.json',
                  buttonText: "",
                  lottieHeight: 250,
                  lottieWidth: 250,
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
