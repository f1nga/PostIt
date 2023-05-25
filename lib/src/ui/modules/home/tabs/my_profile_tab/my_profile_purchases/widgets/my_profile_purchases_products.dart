// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../../routes/routes.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../global_widgets/animation.dart';
import '../../../../../../global_widgets/item_post_finished.dart';

class MyProfilePurchasesProducts extends StatelessWidget {
  const MyProfilePurchasesProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfilePurchasesController controller =
        context.watch<MyProfilePurchasesController>();

    return controller.userPurchasedPosts.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.userPurchasedPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemPostFinished(
                    post: controller.userPurchasedPosts[index],
                    userImage: controller.userCreatedPosts[index].image,
                    comingFromMyProfile: true,
                  );
                },
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 80),
            child: AnimationLottie(
              titleText: "No has hecho ninguna compra",
              descText:
                  "Descubre todas los productos que tenemos y llena esta lista con compras!",
              lottiePath: 'assets/animations/compras.json',
              buttonText: "A comprar",
              lottieWidth: 200,
              lottieHeight: 200,
              onPressed: () => Navigator.popAndPushNamed(
                context,
                Routes.home,
              ),
            ),
          );
  }
}
