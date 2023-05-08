// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/global_widgets/select_image.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/dialogs.dart';
import '../../../../../utils/methods.dart';
import '../../../../global_widgets/custom_form.dart';
import '../../../../global_widgets/input_text.dart';
import '../../../../global_widgets/rounded_button.dart';

import '../register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.isLateLogin});

  final bool isLateLogin;

  void _submit(BuildContext context) async {
    final RegisterController controller = context.read<RegisterController>();
    final bool isFormOK = controller.formKey.currentState!.validate();

    if (isFormOK) {
      ProgressDialog.show(context);

      final bool isOk = await controller.submit();
      Navigator.pop(context);
      if (!isOk) {
        Dialogs.alert(
          context,
          title: "Error",
          description: "Registro fallido",
        );
      } else {
        Methods.showSnackbar(
          context,
          "Registro completado",
        );
        Navigator.pushReplacementNamed(
          context,
          Routes.login,
          arguments: isLateLogin,
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
    final RegisterController controller = context.watch<RegisterController>();

    return CustomForm(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 25,
            ),
            SelectImage(
              circleImage: Methods.getIconState(controller.imageFile),
              onPressed: controller.getFromGallery,
            ),
            const SizedBox(
              height: 25,
            ),
            InputText(
              key: const Key("inputNickname"),
              labelText: "Nickname",
              prefixIcon: const Icon(Icons.person_outline),
              validator: (text) {
                return text.trim().length >= 3 ? null : "Invalid nickname";
              },
              onchanged: controller.onNicknameChanged,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            InputText(
              key: const Key("inputEmail"),
              labelText: "Email",
              prefixIcon: const Icon(Icons.email),
              validator: (text) {
                return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text)
                    ? null
                    : "Invalid email";
              },
              onchanged: controller.onEmailChanged,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            InputText(
              key: const Key("inputPassword"),
              labelText: "Password",
              prefixIcon: const Icon(Icons.key),
              validator: (text) {
                return text.trim().length >= 5 ? null : "Invalid password";
              },
              onchanged: controller.onPasswordChanged,
              textInputAction: TextInputAction.send,
              obscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            InputText(
              key: const Key("inputRepeatPassword"),
              labelText: "Repeat password",
              prefixIcon: const Icon(Icons.key),
              validator: (text) {
                return text.trim().length >= 5 ? null : "Invalid password";
              },
              onSubmitted: (text) => _submit(context),
              onchanged: controller.onPasswordChanged2,
              textInputAction: TextInputAction.send,
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              key: const Key("register_button"),
              onPressed: () {
                if (controller.validatePasswordsMatch() == true) {
                  _submit(context);
                } else {
                  Dialogs.alert(
                    context,
                    title: "Error",
                    description: "Invalid passwords match",
                  );
                }
              },
              label: "Crear la cuenta",
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
