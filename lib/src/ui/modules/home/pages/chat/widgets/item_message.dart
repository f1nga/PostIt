import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/message.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';

class ItemMessage extends StatelessWidget {
  final Message message;

  const ItemMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      alignment: message.sended ? Alignment.centerRight : Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: message.sended
                ? const Color.fromARGB(255, 54, 139, 58)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: message.sended
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: FontStyles.medium.copyWith(
                  fontSize: 16,
                  color: message.sended ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: message.sended
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "${message.date.toDate().hour + 2}:${message.date.toDate().minute}",
                      style: FontStyles.regular.copyWith(fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Visibility(
                      visible: message.sended,
                      child: Icon(
                        Icons.done_all,
                        size: 15,
                        color: message.readed ? primaryColor : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
