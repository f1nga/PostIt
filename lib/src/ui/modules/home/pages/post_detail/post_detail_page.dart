// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/routes/arguments.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/global_widgets/my_post_detail_slider.dart';
import 'package:wallapop/src/ui/global_widgets/rounded_button.dart';
import 'package:wallapop/src/ui/modules/home/pages/post_detail/widgets/buy_button.dart';
import 'package:wallapop/src/utils/dialogs.dart';
import 'package:wallapop/src/utils/methods.dart';

import '../../../../../data/models/user.dart';
import '../../../../../helpers/get.dart';
import 'post_detail_controller.dart';
import 'widgets/post_detail_body.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late final PostDetailController _controller;

  @override
  void initState() {
    _controller = PostDetailController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.afterFistLayout();
    });
    Get.i.put<PostDetailController>(_controller);
    _controller.onDispose = () => Get.i.remove<PostDetailController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Post args = ModalRoute.of(context)!.settings.arguments as Post;

    void goToPurchaseReview() async {
      final bool purchaseCompleted = await _controller.buyProduct(args.id);
      if (purchaseCompleted) {
        Methods.showSnackbar(context, "Compra completada");
        Navigator.pushNamed(
          context,
          Routes.purchaseReview,
          arguments:
              PurchaseReviewArguments(post: args, user: _controller.user!),
        );
      } else {
        Dialogs.alert(
          context,
          title: "Oops!",
          description: "Algo ha salido mal",
          okText: "Reintentar",
        );
      }
    }

    return ChangeNotifierProvider<PostDetailController>(
      create: (_) {
        _controller.getUserByPostId(args.id);
        _controller.onIsPostLiked(args.id);
        _controller.setPostLikes(args.likes);
        _controller.setPostViews(args.views);
        _controller.onIsProfileLiked(args.id);
        _controller.isPostViewed(args.id);
        return _controller;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: args.sold
            ? null
            : BuyButton(
                onPressed: () {
                  Methods.showQuestionDialog(
                    context,
                    "Cuidado",
                    "¿Estas seguro de realizar esta compra?",
                    "Comprar",
                    () => goToPurchaseReview(),
                  );
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Consumer<PostDetailController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        MyPostDetailSlider(
                          images: args.imagesList,
                          comingFromMyPost: false,
                          post: args,
                        ),
                        const PostDetailBody(),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
