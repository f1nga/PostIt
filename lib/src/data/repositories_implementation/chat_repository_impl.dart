import 'package:wallapop/src/data/models/chat.dart';
import 'package:wallapop/src/data/models/message.dart';
import 'package:wallapop/src/data/providers/chat_provider.dart';
import 'package:wallapop/src/data/repositories/chat_repository.dart';

/// Class that implements the provider obligatory methods
class ChatRepositoryImpl implements ChatRepository {
  final ChatProvider _messageProvider;

  ChatRepositoryImpl(this._messageProvider);

  @override
  Future<List<Message>> getMessages(String chatId, String currentUserId) {
    return _messageProvider.getMessages(chatId, currentUserId);
  }

  @override
  Future<Chat?> isChatExists(
      String receiverId, String senderId, String postId) {
    return _messageProvider.isChatExists(receiverId, senderId, postId);
  }

  @override
  Future<bool> addChat(Chat newChat) {
    return _messageProvider.addChat(newChat);
  }

  @override
  Future<bool> updateChat(String chatId, Message m) {
    return _messageProvider.updateChat(chatId, m);
  }

  @override
  Future<List<Chat>> getChatsByUser(String currentUserId) {
    return _messageProvider.getChatsByUser(currentUserId);
  }

  @override
  Future<bool> readChat(String chatId) {
    return _messageProvider.readChat(chatId);
  }
  
  @override
  Future<Message> getLastMessage(String chatId, String currentUserId) {
    return _messageProvider.getLastMessage(chatId, currentUserId);
  }
}
