// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

class MyProfileHeader extends StatelessWidget {
  const MyProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileController controller = context.watch<MyProfileController>();

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(
          15,
        ),
        height: 110,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tertiaryColor.withOpacity(0.5),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipOval(
                    child: Image.network(
                      controller.image!,
                      fit: BoxFit.cover,
                      height: 140,
                      width: 140,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.nickname!,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color:
                            controller.stars! >= 1 ? Colors.amber : Colors.grey,
                      ),
                      Icon(
                        Icons.star,
                        color:
                            controller.stars! >= 2 ? Colors.amber : Colors.grey,
                      ),
                      Icon(
                        Icons.star,
                        color:
                            controller.stars! >= 3 ? Colors.amber : Colors.grey,
                      ),
                      Icon(
                        Icons.star,
                        color:
                            controller.stars! >= 4 ? Colors.amber : Colors.grey,
                      ),
                      Icon(
                        Icons.star,
                        color:
                            controller.stars! >= 5 ? Colors.amber : Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "(${controller.stars.toString()})",
                        style:
                            const TextStyle(color: tertiaryColor, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ],
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        Routes.profileResume,
        arguments: User(nickname: "", email: "")
      ),
    );
  }
}
