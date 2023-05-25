// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../helpers/get.dart';
import '../../../routes/routes.dart';
import 'widgets/splash_screen_bottom_text.dart';
import 'widgets/splash_screen_image_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  final String welcomeImagePath = "assets/welcome/talking_people.jpg";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;

// Sets up a timer to wait for 800 milliseconds before checking
//if the user is authenticated. If the user is not authenticated,
//it navigates to the welcome screen, otherwise it navigates to the home screen.
//This function is typically called when the corresponding widget is initialized.
  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(
        milliseconds: 800,
      ),
      () async {
        // await Init.initialize(); nomes en cas de crear una nova base de dades de projecte flutter per popular la BD

        bool isLogged =
            await Get.i.find<AuthenticationRepository>()!.tokenExists();

        if (!isLogged) {
          Navigator.pushReplacementNamed(
            context,
            Routes.welcome,
          );
        } else {
          await Get.i.find<AuthenticationRepository>()!.myUser();
          Navigator.pushReplacementNamed(
            context,
            Routes.home,
          );
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage(widget.welcomeImagePath), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SplashScreenImage(),
                SplashScreenBottomText(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
