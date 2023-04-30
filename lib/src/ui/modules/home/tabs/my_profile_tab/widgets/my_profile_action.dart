import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:provider/provider.dart';

class MyProfileAction extends StatelessWidget {
  final Icon icon;
  final String title;
  const MyProfileAction({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final MyProfileController controller = context.watch<MyProfileController>();

    return Container(
      padding: const EdgeInsets.all(
        15,
      ),
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15.0,
          ),
        ],
      ),
    );
  }
}
