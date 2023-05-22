import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/models/message.dart';
import 'package:wallapop/src/data/repositories/message_repository.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

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

  String _messageContent = "";
  String get messageContent => _messageContent;

  bool _stream = true;
  bool get stream => _stream;

  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController get textFieldController => _textFieldController;

  void Function()? onDispose;

  void afterFistLayout(User u) {
    _init(u);
  }

  void _init(User u) async {
    _currentUser = await _usersRepository.getCurrentUser();
    _receiverUser = u;

    _messagesList = await _messagesRepository.getMessages(
        _receiverUser.id, _currentUser.id);

    iniciarConsultaPeriodica();

    notifyListeners();
  }

  void iniciarConsultaPeriodica() {
    Timer.periodic(const Duration(seconds: 1), (_) async {
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
