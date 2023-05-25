import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/global_widgets/animation.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/utils/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import '../../../../../../global_widgets/item_post.dart';

class MyProfileResumeProducts extends StatelessWidget {
  const MyProfileResumeProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return controller.userPosts.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: backgroundColor,
              height: MediaQuery.of(context).size.height - 280,
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10),
                itemCount: controller.userPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemPost(
                    post: controller.userPosts[index],
                    comingFromMyProfile: true,
                  );
                },
              ),
            ),
          )
        : AnimationLottie(
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
          );
  }
}
