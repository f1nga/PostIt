import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';

import '../../../../utils/font_styles.dart';
import 'login_controller.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(),
      builder: (_, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              key: const Key("login_title"),
              "Introduce tus credenciales",
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
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: const LoginForm(
                isLateLogin: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
