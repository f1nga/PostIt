import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_controller.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

class MyProfileResumeHeader extends StatelessWidget {
  const MyProfileResumeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 110,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.nickname!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
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
                      const SizedBox(width: 5),
                      Text(
                        "(${controller.stars.toString()})",
                        style: const TextStyle(
                          color: tertiaryColor,
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tertiaryColor.withOpacity(0.5),
              ),
              child: ClipOval(
                child: Image.network(
                  controller.image!,
                  fit: BoxFit.cover,
                  height: 140,
                  width: 140,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Row(
          children: [
            const Icon(Icons.graphic_eq),
            const SizedBox(
              width: 10,
            ),
            Text("${controller.sales} ventas"),
            const SizedBox(
              width: 10,
            ),
            Text("${controller.purchases} Compras"),
          ],
        ),
      ),
    ]);
  }
}
