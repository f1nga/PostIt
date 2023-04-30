// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/user.dart';
import '../../../../helpers/get.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/font_styles.dart';
import '../home_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.hideDrawer,
  });

  final VoidCallback hideDrawer;

  // Logs out the current user by clearing their session and removing their data from the app.
  // Retrieve the shared preferences instance for persistent storage.
  void _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.i.remove<User>();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.welcome,
      (route) => false,
    );
  }

  // Displays an alert dialog box to confirm the user's intention to log out.
  // The dialog box contains the title and description texts for the alert,
  // along with an 'OK' button to trigger the log out process. The context parameter
  // is used to display the dialog box, and the _logout function is called when the 'OK' button is pressed.
  void _logoutAlertDialog(BuildContext context) {
    Dialogs.alert(
      context,
      title: "Cuidado",
      description: "Estás a punto de cerrar la sesión",
      okText: "OK",
      onPressed: () => _logout(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool sessionToken =
        context.select<HomeController, bool>((_) => _.userToken);

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "PostIt Menú",
                      style: FontStyles.title,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MaterialButton(
                      key: const Key("create_debate_button"),
                      onPressed: () => {},
                      child: Text(
                        "Crear hol",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MaterialButton(
                      key: const Key("create_group_button"),
                      onPressed: () =>{},
                      child: const Text(
                        "crear hol",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MaterialButton(
                      key: const Key("my_interactions_button"),
                      onPressed: () => {},
                      child: const Text(
                        "My interactions",
                      ),
                    ),
                  ),
                  if (sessionToken)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MaterialButton(
                        key: const Key("my_profile_button"),
                        onPressed: () => {},
                        child: const Text(
                          "Perfil",
                        ),
                      ),
                    ),
                ],
              ),
              sessionToken
                  ? GestureDetector(
                      key: const Key("logout_button"),
                      onTap: () => _logoutAlertDialog(context),
                      //   // hideDrawer();
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Logout",
                          ),
                          )
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.login
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.login),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text("Login"),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
