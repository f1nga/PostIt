import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/models/chat.dart';
import 'package:wallapop/src/data/repositories/chat_repository.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../data/models/message.dart';
import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../helpers/get.dart';

class MailboxTabController extends ChangeNotifier {
  final ChatRepository _chatsRepository = Get.i.find<ChatRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;
  final PostRepository _postRepository = Get.i.find<PostRepository>()!;

  User? _currentUser;
  User? get currentUser => _currentUser;

  List<Chat> _chatsList = [];
  List<Chat> get chatsList => _chatsList;

  final List<Message> _lastMessageList = [];
  List<Message> get lastMessageList => _lastMessageList;

  final List<Post> _postsList = [];
  List<Post> get postsList => _postsList;

  final List<User> _receiverUserList = [];
  List<User> get receiverUserList => _receiverUserList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _currentUser = await _usersRepository.getCurrentUser();

    _chatsList = await _chatsRepository.getChatsByUser(_currentUser!.id);

    for (Chat chat in _chatsList) {
      _postsList.add(await _postRepository.getPostById(chat.postId));

      chat.receiverId != _currentUser!.id
          ? _receiverUserList
              .add(await _usersRepository.getUserById(chat.receiverId))
          : _receiverUserList
              .add(await _usersRepository.getUserById(chat.senderId));
      // if (chat.receiverId != _currentUser!.id) {
      //   _receiverUserList
      //       .add(await _usersRepository.getUserById(chat.receiverId));
      // } else {
      //   _receiverUserList
      //       .add(await _usersRepository.getUserById(chat.senderId));
      // }

      // final list =
      //     await _chatsRepository.getLastMessage(chat.id, _currentUser!.id);
      _lastMessageList.add(await _chatsRepository.getLastMessage(chat.id, _currentUser!.id));
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> readChat(String chatId) async {
    await _chatsRepository.readChat(chatId);
  }
}
