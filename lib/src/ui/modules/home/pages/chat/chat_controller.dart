import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/models/chat.dart';
import 'package:wallapop/src/data/models/message.dart';
import 'package:wallapop/src/data/repositories/chat_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../helpers/get.dart';

class ChatController extends ChangeNotifier {
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;
  final ChatRepository _messagesRepository = Get.i.find<ChatRepository>()!;

  late User _currentUser;

  List<Message> _messagesList = [];
  List<Message> get messagesList => _messagesList;

  late User _receiverUser;
  User get receiverUser => _receiverUser;

  late Post _postChat;
  Post get postChat => _postChat;

  Chat? _chat;
  Chat? get chat => _chat;

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

    _chat = await _messagesRepository.isChatExists(
      _currentUser.id,
      _receiverUser.id,
      postChat.id,
    );

    if (_chat != null) {
      _messagesList =
          await _messagesRepository.getMessages(_chat!.id, _currentUser.id);
    }

    iniciarConsultaPeriodica();

    notifyListeners();
  }

  void iniciarConsultaPeriodica() {
    Timer.periodic(const Duration(seconds: 3), (_) async {
      if (_stream) {
        _messagesList =
            await _messagesRepository.getMessages(_chat!.id, _currentUser.id);

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

  void closeStream() {
    _stream = false;
    notifyListeners();
  }

  void onIsSendingMessageChanges(String message) {
    _messageContent = message;
    notifyListeners();
  }

  Future<bool> submit() async {
    try {
      if (_chat == null) {
        Message newMessage = Message(
          content: _messageContent,
          senderId: _currentUser.id,
        );
        if (await _messagesRepository.addChat(
          Chat(
            senderId: _currentUser.id,
            receiverId: _receiverUser.id,
            postId: postChat.id,
            messagesList: [newMessage.toMap()],
          ),
        )) {
          _messagesList.add(newMessage);
          notifyListeners();
        }
      } else {
        Message newMessage = Message(
          content: _messageContent,
          senderId: _currentUser.id,
        );
        if (await _messagesRepository.updateChat(
          _chat!.id,
          newMessage,
        )) {
          _messagesList.add(newMessage);
          notifyListeners();
        }
      }

      _textFieldController.clear();

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }
}
