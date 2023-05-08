import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/ui/global_widgets/custom_rounded_button.dart';
import 'package:wallapop/src/ui/global_widgets/custom_rounded_button_with_icon.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_post_detail/widgets/button_category.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/methods.dart';

class MyPostDetailBody extends StatefulWidget {
  final Post post;

  const MyPostDetailBody({
    super.key,
    required this.post,
  });

  @override
  State<MyPostDetailBody> createState() => _MyPostDetailBodyState();
}

class _MyPostDetailBodyState extends State<MyPostDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomRoundedButton(
                onPressed: () => {},
                title: "Reservar",
                buttonColor: const Color.fromARGB(255, 33, 93, 243),
                textColor: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomRoundedButton(
                onPressed: () => {},
                title: "Vendido",
                buttonColor: const Color.fromARGB(255, 191, 29, 80),
                textColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "${widget.post.price} €",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.post.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.post.state,
          ),
          const SizedBox(
            height: 15,
          ),
          ButtonCategory(
            title: widget.post.category,
            onPressed: () => {},
            icon: Methods.getCategoryIcon(widget.post.category),
            width: 150,
            buttonColor: backgroundColor,
            textColor: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.post.description,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Editado hace 0 minutos"),
              Spacer(),
              Icon(Icons.remove_red_eye_outlined),
              SizedBox(
                width: 8,
              ),
              Text("0"),
              SizedBox(
                width: 8,
              ),
              Icon(Icons.favorite_border_outlined),
              SizedBox(
                width: 8,
              ),
              Text("0"),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
