import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/global_widgets/select_image.dart';
import 'package:wallapop/src/ui/modules/welcome/widgets/header_details_widget.dart';

import '../../../../utils/colors.dart';

import '../../../../utils/font_styles.dart';
import 'register_controller.dart';
import 'widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
      create: (_) => RegisterController(),
      builder: (_, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Crea una cuenta",
              style: FontStyles.title.copyWith(
                color: secondaryColor,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: const [
                      RegisterForm(isLateLogin: false),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
