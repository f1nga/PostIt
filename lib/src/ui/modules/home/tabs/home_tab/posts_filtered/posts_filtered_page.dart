import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/global_widgets/item_post_finished.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/posts_filtered/widgets/posts_filtered_products.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_purchases/my_profile_purchases_controller.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_purchases/widgets/my_profile_purchases_products.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_action.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/widgets/my_profile_header.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../helpers/get.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';
import 'posts_filtered_controller.dart';

class PostsFilteredPage extends StatefulWidget {
  const PostsFilteredPage({super.key});

  @override
  State<PostsFilteredPage> createState() => _PostsFilteredPageState();
}

class _PostsFilteredPageState extends State<PostsFilteredPage> {
  late final PostsFilteredController controller;

  @override
  void initState() {
    controller = PostsFilteredController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.afterFistLayout();
    });
    Get.i.put<PostsFilteredController>(controller);
    controller.onDispose = () => Get.i.remove<PostsFilteredController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Post> postsList =
        ModalRoute.of(context)!.settings.arguments as List<Post>;

    controller.setPostsList(postsList);

    return ChangeNotifierProvider<PostsFilteredController>(
      create: (_) => controller,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Encuentra lo que buscas',
                    style: FontStyles.title.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const PostsFilteredProducts(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
