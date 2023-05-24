import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../../routes/routes.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../global_widgets/animation.dart';
import '../../../../../../global_widgets/item_post_finished.dart';
import '../my_profile_sales_controller.dart';

class MyProfileSalesProducts extends StatelessWidget {
  const MyProfileSalesProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileSalesController controller =
        context.watch<MyProfileSalesController>();

    return controller.userSalesPosts.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.userSalesPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemPostFinished(
                    post: controller.userSalesPosts[index],
                    userImage: controller.userCreatedPosts[index].image,
                    comingFromMyProfile: !controller.isOnSaleCliked,
                  );
                },
              ),
            ),
          )
        : controller.isOnSaleCliked
            ? Padding(
                padding: const EdgeInsets.only(top: 50),
                child: AnimationLottie(
                  titleText: "Nada en venta todavía",
                  descText:
                      "Créenos, es muuucho mejor cuando vendes cosas. Sube algo que quieras vender!",
                  lottiePath: 'assets/animations/shop.json',
                  buttonText: "Subir producto",
                  lottieWidth: 200,
                  lottieHeight: 200,
                  onPressed: () => Navigator.popAndPushNamed(
                    context,
                    Routes.home,
                    arguments: 2,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 50),
                child: AnimationLottie(
                  titleText: "Sin ventas finalizadas todavía",
                  descText:
                      "Si quieres vender algo, simplemente súbelo. Si lo haces con cariño, mucho mejor!",
                  lottiePath: 'assets/animations/sell.json',
                  buttonText: "Subir producto",
                  lottieWidth: 200,
                  lottieHeight: 200,
                  onPressed: () => Navigator.popAndPushNamed(
                    context,
                    Routes.home,
                    arguments: 2,
                  ),
                ),
              );
  }
}
