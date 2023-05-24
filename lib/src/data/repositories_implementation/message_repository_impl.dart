import 'dart:io';

import 'package:wallapop/src/data/models/chat.dart';
import 'package:wallapop/src/data/models/message.dart';
import 'package:wallapop/src/data/providers/message_provider.dart';
import 'package:wallapop/src/data/repositories/message_repository.dart';

import '../models/user.dart';
import '../providers/authentication_provider.dart';
import '../repositories/authentication_repository.dart';

/// Class that implements the provider obligatory methods
class MessageRepositoryImpl implements MessageRepository {
  final MessageProvider _messageProvider;

  MessageRepositoryImpl(this._messageProvider);

  @override
  Future<List<Message>> getMessages(String receiverId, String senderId) {
    return _messageProvider.getMessages(receiverId, senderId);
  }

  @override
  Future<bool> addMessage(Message newMessage) {
    return _messageProvider.addMessage(newMessage);
  }

  @override
  Future<Chat?> isChatExists(String receiverId, String senderId, String postId) {
    return _messageProvider.isChatExists(receiverId, senderId, postId);
  }

  @override
  Future<bool> addChat(Chat newChat) {
    return _messageProvider.addChat(newChat);
  }

  @override
  Future<bool> updateChat(String chatId, List messages) {
    return _messageProvider.updateChat(chatId, messages);
  }
}
