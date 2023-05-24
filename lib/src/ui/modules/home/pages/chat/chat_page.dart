import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/routes/arguments.dart';
import 'package:wallapop/src/ui/global_widgets/input_text.dart';
import 'package:wallapop/src/ui/modules/home/pages/chat/chat_controller.dart';
import 'package:wallapop/src/ui/modules/home/pages/chat/widgets/chat_appbar.dart';
import 'package:wallapop/src/ui/modules/home/pages/chat/widgets/item_message.dart';

import '../../../../../data/models/message.dart';
import '../../../../../helpers/get.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/font_styles.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final ChatArguments args =
        ModalRoute.of(context)!.settings.arguments as ChatArguments;

    return ChangeNotifierProvider<ChatController>(
      create: (_) {
        final ChatController controller = ChatController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFistLayout(args.user, args.post);
        });
        Get.i.put<ChatController>(controller);
        controller.onDispose = () {
          Get.i.remove<ChatController>();
        };
        return controller;
      },
      builder: (_, __) {
        final ChatController controller =
            Provider.of<ChatController>(_, listen: true);

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              ChatAppbar(
                post: args.post,
                user: args.user,
              ),
              const Divider(
                thickness: 1,
                color: tertiaryColor,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.messagesList.length,
                  itemBuilder: (BuildContext context, int index) {  
                    return ItemMessage(
                      message: controller.messagesList[index],
                    );
                  },
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.textFieldController,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Escribe algo...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (value) =>
                            controller.onIsSendingMessageChanges(value),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.submit();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
