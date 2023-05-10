import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/postit_controller.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/widgets/postit_form.dart';

import '../../../../../utils/colors.dart';

class PostitTab extends StatelessWidget {
  const PostitTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostitController>(
      create: (_) => PostitController(),
      builder: (_, __) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: const PostitForm(),
            ),
          ),
        );
      },
    );
  }
}
