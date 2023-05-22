// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/review.dart';
import 'package:wallapop/src/routes/arguments.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/global_widgets/item_post.dart';
import 'package:wallapop/src/ui/global_widgets/rounded_button.dart';
import 'package:wallapop/src/ui/global_widgets/user_stars.dart';
import 'package:wallapop/src/ui/modules/home/pages/purchase_review/purchase_review_controller.dart';
import 'package:wallapop/src/ui/modules/home/pages/purchase_review/widgets/select_stars.dart';
import 'package:wallapop/src/utils/dialogs.dart';

import '../../../../../data/models/post.dart';
import '../../../../../helpers/get.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/font_styles.dart';
import '../../../../../utils/methods.dart';

class PurchaseReviewPage extends StatefulWidget {
  const PurchaseReviewPage({super.key});

  @override
  State<PurchaseReviewPage> createState() => _PurchaseReviewPageState();
}

class _PurchaseReviewPageState extends State<PurchaseReviewPage> {
  late final PurchaseReviewController _controller;

  @override
  void initState() {
    _controller = PurchaseReviewController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.afterFistLayout();
    });
    Get.i.put<PurchaseReviewController>(_controller);
    _controller.onDispose = () => Get.i.remove<PurchaseReviewController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PurchaseReviewArguments args =
        ModalRoute.of(context)!.settings.arguments as PurchaseReviewArguments;

    void submit() async {
      if (_controller.clickedStars == 0) {
        Dialogs.alert(
          context,
          title: "Cuidado",
          description: "Debes elegir alguna estrella",
        );
      } else {
        final bool reviewSended = await _controller.onIsSendReviewButtonClicked(
          Review(
            email: args.user.email,
            stars: _controller.clickedStars,
            postId: args.post.id,
            description: _controller.descriptionReview,
          ),
        );

        final bool starsUpdated =
            await _controller.updateUserStarsFromDB(args.user);

        if (reviewSended && starsUpdated) {
          Methods.showSnackbar(
            context,
            "Review enviada",
          );
          Navigator.popAndPushNamed(
            context,
            Routes.home,
          );
        } else {
          Dialogs.alert(
            context,
            title: "Cuidado",
            description: "No se ha podido completar la reseña",
          );
        }
      }
    }

    return ChangeNotifierProvider<PurchaseReviewController>(
      create: (_) => _controller,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Escribe tu reseña",
            style: FontStyles.title.copyWith(
              color: secondaryColor,
            ),
          ),
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            key: const Key("arrow_back_icon"),
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
        ),  
        body: SingleChildScrollView(
          child: Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Como valoras tu experiencia con ${args.user.nickname}",
                  style: FontStyles.title,
                ),
                const SizedBox(
                  height: 30,
                ),
                const SelectStars(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Compra realizada:",
                  style: FontStyles.subtitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                ItemPost(
                  post: args.post,
                  comingFromMyProfile: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  maxLength: 100,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Escribe tu reseña aquí",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintStyle: const TextStyle(color: primaryColor),
                  ),
                  onChanged: (value) =>
                      _controller.onReviewDescriptionChanged(value),
                ),
                const SizedBox(
                  height: 25,
                ),
                RoundedButton(onPressed: submit, label: "Enviar reseña")
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
