// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../../data/providers/firebase/init.dart';
import '../../../data/models/chat.dart';
import '../../../data/models/messages.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../helpers/get.dart';
import '../../../routes/routes.dart';
import '../../../utils/methods.dart';
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
          // Chat chat = Chat(
          //     senderId: "3d8aec7c-9897-4c79-b0ba-c11637bb9365",
          //     receiverId: "033f928e-46f7-4023-a13f-b69181f49033",
          //     postId: "321d4a13-8018-414c-a73e-9a46254dfb00",
          //     messagesList: [
          //       Messages(
          //           content: "Hola bon dia",
          //           senderId: '3d8aec7c-9897-4c79-b0ba-c11637bb9365').toMap()
          //     ]);
          // await FirebaseFirestore.instance
          //     .collection("chat_store")
          //     .doc(chat.id)
          //     .set(
          //       chat.toMap(),
          //     );

          // final record = await FirebaseFirestore.instance
          //     .collection("chat_store")
          //     .where(
          //       "id",
          //       isEqualTo: "3d2840cb-d0e3-4273-8b8a-f075d8cc62da",
          //     )
          //     .limit(1)
          //     .get();

          // Map<String, dynamic> map = record.docs.first.data();

          // Chat chat = Chat.fromMap(map);

          // Messages mess = Messages.fromMap(chat.messagesList[0]);
          // print(mess.content);

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
