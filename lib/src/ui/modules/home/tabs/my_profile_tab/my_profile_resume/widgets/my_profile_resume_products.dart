import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

class MyProfileResumeProducts extends StatelessWidget {
  const MyProfileResumeProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: 445,
      color: Colors.white,
      child: GridView.builder(
        itemCount: controller.userPosts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Image.network(
                      controller.userPosts[index].image,
                      fit: BoxFit.cover,
                      height: 140,
                      width: 140,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "${controller.userPosts[index].price}€",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.userPosts[index].description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
            onTap: () => Navigator.popAndPushNamed(
              context,
              Routes.postDetail,
              arguments: controller.userPosts[index],
            ),
          );
        },
      ),
    );
  }
}
