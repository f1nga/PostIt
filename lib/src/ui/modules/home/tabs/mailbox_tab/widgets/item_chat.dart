// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/arguments.dart';
import 'package:wallapop/src/routes/routes.dart';
import 'package:wallapop/src/ui/modules/home/tabs/mailbox_tab/malbox_tab_controller.dart';
import 'package:wallapop/src/utils/colors.dart';
import 'package:wallapop/src/utils/font_styles.dart';
import 'package:wallapop/src/utils/methods.dart';

import 'package:provider/provider.dart';

class ItemChat extends StatelessWidget {
  final int index;

  const ItemChat({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final MailboxTabController controller =
        context.watch<MailboxTabController>();

    return InkWell(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        controller.postsList[index].imagesList[0],
                        fit: BoxFit.cover,
                        height: 50,
                        width: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.receiverUserList[index].nickname,
                          style: FontStyles.subtitle
                              .copyWith(color: tertiaryColor),
                        ),
                        Text(
                          controller.postsList[index].title,
                          style: FontStyles.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              controller.lastMessageList[index].content,
                              style: FontStyles.subtitle
                                  .copyWith(color: tertiaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Visibility(
                              visible: !controller.lastMessageList[index].readed,
                              child: const Icon(
                                Icons.circle,
                                color: primaryColor,
                                size: 10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        Methods.formatDate2(
                            controller.lastMessageList[index].date.toDate()),
                        style:
                            FontStyles.subtitle.copyWith(color: tertiaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: tertiaryColor,
            ),
          ],
        ),
        onTap: () async {
          await controller.readChat(controller.chatsList[index].id);
          Navigator.pushNamed(
            context,
            Routes.chat,
            arguments: ChatArguments(
              post: controller.postsList[index],
              user: controller.receiverUserList[index],
            ),
          );
        });
  }
}
