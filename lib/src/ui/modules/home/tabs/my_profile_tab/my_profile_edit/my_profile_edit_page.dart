// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/global_widgets/rounded_button.dart';
import 'package:wallapop/src/ui/global_widgets/select_image.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_edit/widgets/edit_profile_text_field.dart';
import 'package:wallapop/src/utils/dialogs.dart';
import 'package:wallapop/src/utils/methods.dart';

import '../../../../../../helpers/get.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';
import 'my_profile_edit_controller.dart';

class MyProfileEditPage extends StatefulWidget {
  const MyProfileEditPage({super.key});

  @override
  State<MyProfileEditPage> createState() => _MyProfileEditPageState();
}

class _MyProfileEditPageState extends State<MyProfileEditPage> {
  late final MyProfileEditController controller;

  @override
  void initState() {
    controller = MyProfileEditController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.afterFistLayout();
    });
    Get.i.put<MyProfileEditController>(controller);
    controller.onDispose = () => Get.i.remove<MyProfileEditController>();
    super.initState();
  }

  void submit() async {
    final bool isOK = await controller.submit();

    if (isOK) {
      Methods.showSnackbar(context, "Se han modificado tus datos");
      Navigator.popAndPushNamed(
        context,
        Routes.home,
        arguments: 3,
      );
    } else {
      Dialogs.alert(
        context,
        title: "Vaya!",
        description: "Revisa los campos",
        okText: "Reintentar",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProfileEditController>(
      create: (_) => controller,
      builder: (_, __) {
        final controller = Provider.of<MyProfileEditController>(
          _,
          listen: true,
        );
        if (controller.currentUser != null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Editar el perfil",
                style: FontStyles.title.copyWith(
                  color: secondaryColor,
                ),
              ),
              centerTitle: false,
              leading: IconButton(
                key: const Key("arrow_back_icon"),
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Builder(builder: (context) {
                          if (controller.imageLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return SelectImage(
                              circleImage: Image.network(
                                controller.currentUser!.image,
                                fit: BoxFit.fill,
                              ),
                              width: 100,
                              height: 100,
                              onPressed: controller.getFromGallery,
                            );
                          }
                        }),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Información de la cuenta",
                        style: FontStyles.title.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      EditProfileTextField(
                        label: "Nombre",
                        textController: controller.textFieldNameController,
                        textInputType: TextInputType.name,
                      ),
                      EditProfileTextField(
                        label: "Email",
                        textController: controller.textFieldEmailController,
                        textInputType: TextInputType.emailAddress,
                      ),
                      EditProfileTextField(
                        label: "Teléfono",
                        textController: controller.textFieldPhoneController,
                        textInputType: TextInputType.phone,
                      ),
                      EditProfileTextField(
                        label: "Descripción",
                        textController:
                            controller.textFieldDescriptionController,
                      ),
                      EditProfileTextField(
                        label: "Fecha de nacimiento",
                        textController: controller.textFieldBirthDateController,
                        textInputType: TextInputType.datetime,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RoundedButton(
                          onPressed: () => submit(), label: "Guardar cambios")
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: backgroundColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
