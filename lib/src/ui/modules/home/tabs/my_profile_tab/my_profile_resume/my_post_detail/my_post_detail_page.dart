// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_post_detail/widgets/my_post_detail_body.dart';
import 'package:wallapop/src/ui/global_widgets/my_post_detail_slider.dart';

import 'my_post_detail_controller.dart';

class MyPostDetailPage extends StatefulWidget {
  const MyPostDetailPage({super.key});

  @override
  State<MyPostDetailPage> createState() => _MyPostDetailPageState();
}

class _MyPostDetailPageState extends State<MyPostDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Post args = ModalRoute.of(context)!.settings.arguments as Post;

    return ChangeNotifierProvider<MyPostDetailController>(
      create: (_) => MyPostDetailController(),
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
