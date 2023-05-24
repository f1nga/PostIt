import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/models/chat.dart';
import 'package:wallapop/src/data/models/message.dart';
import 'package:wallapop/src/data/repositories/message_repository.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../data/models/messages.dart';
import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../helpers/get.dart';

class ChatController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;
  final MessageRepository _messagesRepository =
      Get.i.find<MessageRepository>()!;

  late User _currentUser;

  List<Message> _messagesList = [];
  List<Message> get messagesList => _messagesList;

  late User _receiverUser;
  User get receiverUser => _receiverUser;

  late Post _postChat;
  Post get postChat => _postChat;

  String _messageContent = "";
  String get messageContent => _messageContent;

  bool _stream = true;
  bool get stream => _stream;

  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController get textFieldController => _textFieldController;

  void Function()? onDispose;

  void afterFistLayout(User u, Post p) {
    _init(u, p);
  }

  void _init(User u, Post p) async {
    _currentUser = await _usersRepository.getCurrentUser();
    _receiverUser = u;
    _postChat = p;

    _messagesList = await _messagesRepository.getMessages(
        _receiverUser.id, _currentUser.id);

    //iniciarConsultaPeriodica();

    notifyListeners();
  }

  void iniciarConsultaPeriodica() {
    Timer.periodic(const Duration(seconds: 2), (_) async {
      if (_stream) {
        _messagesList = await _messagesRepository.getMessages(
            _receiverUser.id, _currentUser.id);

        notifyListeners();
      } else {
        return;
      }
    });
  }

  @override
  void dispose() {
    _stream = false;
    super.dispose();
  }

  void onIsSendingMessageChanges(String message) {
    _messageContent = message;
    notifyListeners();
  }

  Future<bool> submit() async {
    Message newMessage = Message(
      senderId: _currentUser.id,
      receiverId: _receiverUser.id,
      content: _messageContent,
    );
    if (await _messagesRepository.addMessage(newMessage)) {
      _messagesList.add(newMessage);
      _textFieldController.clear();
      notifyListeners();

      final Chat? chatFound = await _messagesRepository.isChatExists(
        _currentUser.id,
        _receiverUser.id,
        postChat.id,
      );

      if (chatFound == null) {
        await _messagesRepository.addChat(
          Chat(
            senderId: _currentUser.id,
            receiverId: _receiverUser.id,
            postId: postChat.id,
            messagesList: [
              Messages(
                content: _messageContent,
                senderId: _currentUser.id,
              ).toMap()
            ],
          ),
        );
      } else {
        // final record = await FirebaseFirestore.instance
        //     .collection("chat_store")
        //     .doc("ce47ea39-5187-4716-bf51-ae15fe2c6ac8")
        //     .get();

        // Chat chat = Chat.fromMap(record.data()!);
        print("hoool1");
        chatFound.messagesList.add(
            Messages(senderId: _currentUser.id, content: messageContent)
                .toMap());
                        print("hoool2");

        await _messagesRepository.updateChat(
            chatFound.id, chatFound.messagesList);
                    print("hoool3");

      }
      return true;
    }
    return false;
    // return _messagesRepository.addMessage(
    //   Message(
    //       senderId: _currentUser.id,
    //       receiverId: _receiverUser.id,
    //       content: _messageContent),
    // );
  }
}
