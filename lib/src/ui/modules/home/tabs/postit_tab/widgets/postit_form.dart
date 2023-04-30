// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/postit_controller.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/widgets/category_selection.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/widgets/state_selection.dart';
import 'package:wallapop/src/utils/colors.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/dialogs.dart';
import '../../../../../../utils/methods.dart';
import '../../../../../global_widgets/custom_form.dart';
import '../../../../../global_widgets/input_text.dart';
import '../../../../../global_widgets/rounded_button.dart';

class PostitForm extends StatefulWidget {
  const PostitForm({super.key});

  @override
  State<PostitForm> createState() => _PostitFormState();
}

class _PostitFormState extends State<PostitForm> {
  void _submit(BuildContext context) async {
    final PostitController controller = context.read<PostitController>();
    final bool isFormOK = controller.formKey.currentState!.validate();

    if (isFormOK) {
      ProgressDialog.show(context);

      final bool isOk = await controller.submit();
      Navigator.pop(context);
      if (!isOk) {
        Dialogs.alert(
          context,
          title: "Error",
          description: "No se ha podido subir el post",
        );
      } else {
        Methods.showSnackbar(context, "Post completado!");
        //Snack bar informativa
        Navigator.popAndPushNamed(
          context,
          Routes.home,
        );
      }
    } else {
      Dialogs.alert(
        context,
        title: "Error",
        description: "Revise los campos",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final PostitController controller = context.watch<PostitController>();

    return CustomForm(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tertiaryColor.withOpacity(0.5),
                ),
                width: 70,
                height: 70,
                child: ClipOval(
                  child: controller.getIconState(),
                ),
              ),
              onTap: () => controller.getFromGallery(),
            ),
            const SizedBox(
              height: 20,
            ),
            InputText(
              onchanged: controller.onTitleChanged,
              prefixIcon: const Icon(Icons.title),
              validator: (text) {
                if (text.trim().length >= 4 && text.trim().length <= 15) {
                  return null;
                }
                return "Título no válido";
              },
              labelText: "Título",
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            InputText(
              onchanged: controller.onDescriptionChanged,
              onSubmitted: (text) => /*_authenticate(context)*/ {},
              prefixIcon: const Icon(Icons.description),
              validator: (text) {
                if (text.trim().length >= 4 && text.trim().length <= 100) {
                  return null;
                }
                return "Descripción no válida";
              },
              labelText: "Descripción",
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 5,
            ),
            const CategorySelection(),
            const Divider(
              color: Color.fromARGB(255, 50, 49, 49),
              thickness: 0.7,
            ),
            const StateSelection(),
            const Divider(
              color: Color.fromARGB(255, 50, 49, 49),
              thickness: 0.7,
            ),
            InputText(
              onchanged: controller.onPriceChanged,
              prefixIcon: const Icon(Icons.euro),
              validator: (text) {
                if (text.isEmpty || !(double.parse(text) > 0.0)) {
                  return "Precio no válido";
                }
                return null;
              },
              labelText: "Precio",
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              onPressed: () => _submit(context),
              label: "Subir Producto",
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
