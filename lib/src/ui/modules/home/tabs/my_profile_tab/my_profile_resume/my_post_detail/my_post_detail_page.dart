import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_post_detail/widgets/my_post_detail_body.dart';
import 'package:wallapop/src/ui/global_widgets/my_post_detail_slider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';

import '../../../../../../../helpers/get.dart';
import '../../../../../../../routes/routes.dart';
import '../../../../../../../utils/colors.dart';

class MyPostDetailPage extends StatefulWidget {
  const MyPostDetailPage({super.key});

  @override
  State<MyPostDetailPage> createState() => _MyPostDetailPageState();
}

class _MyPostDetailPageState extends State<MyPostDetailPage> {
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
                MyPostDetailSlider(
                  images: args.imagesList,
                  comingFromMyPost: true,
                  post: args,
                ),
                MyPostDetailBody(post: args)
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
