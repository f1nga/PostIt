// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/user.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/dialogs.dart';
import '../../../../global_widgets/custom_form.dart';
import '../../../../global_widgets/input_text.dart';
import '../../../../global_widgets/rounded_button.dart';

import '../login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.isLateLogin});

  final bool isLateLogin;

  // This function is used to authenticate a user with their login credentials.
  // Access the LoginController using the context and check if the login form is valid.
  // If the form is valid, show a progress dialog and attempt to authenticate the user.
  void _authenticate(BuildContext context) async {
    final LoginController controller = context.read<LoginController>();
    final bool isFormOK = controller.formKey.currentState!.validate();

    if (isFormOK) {
      ProgressDialog.show(context);

      final User? user = await controller.authenticate();
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(
          context,
          title: "Error",
          description: "El usuario no existe",
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (route) => false,
        );
      }
    } else {
      Dialogs.alert(
        context,
        title: "Error",
        description: "Invalid inputs",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final LoginController controller = context.watch<LoginController>();

    return CustomForm(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 25,
            ),
            InputText(
              key: const Key("emailInput"),
              onchanged: controller.onEmailChanged,
              prefixIcon: const Icon(Icons.email),
              validator: (text) {
                return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text)
                    ? null
                    : "Email no válido";
              },
              labelText: "Correo electrónico",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            InputText(
              key: const Key("passwordInput"),
              onchanged: controller.onPasswordChanged,
              onSubmitted: (text) => _authenticate(context),
              prefixIcon: const Icon(Icons.key),
              validator: (text) {
                if (text.trim().length >= 5) return null;
                return "Contraseña no valida";
              },
              labelText: "Contraseña",
              obscureText: true,
              textInputAction: TextInputAction.send,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              key: const Key("login_button"),
              onPressed: () => _authenticate(context),
              label: "Acceder",
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
