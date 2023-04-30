import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/ui/modules/home/pages/post_detail/widgets/post_detail_body.dart';
import 'package:wallapop/src/ui/modules/home/pages/post_detail/widgets/post_detail_slider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';

import '../../../../../helpers/get.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/colors.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Post args = ModalRoute.of(context)!.settings.arguments as Post;

    return ChangeNotifierProvider<MyProfileController>(
      create: (_) {
        final MyProfileController controller = MyProfileController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout();
        });
        Get.i.put<MyProfileController>(controller);
        controller.onDispose = () => Get.i.remove<MyProfileController>();
        return controller;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PostDetailSlider(
                  images: [args.image],
                ),
                PostDetailBody(post: args)
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
