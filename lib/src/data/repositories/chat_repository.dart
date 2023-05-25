import "package:wallapop/src/data/models/message.dart";
import "../models/chat.dart";

/// Abstract class that contains the necessary methods for the provider
abstract class ChatRepository {
  Future<List<Message>> getMessages(String chatId, String currentUserId);
  Future<bool> addChat(Chat newChat);
  Future<Chat?> isChatExists(String receiverId, String senderId, String postId);
  Future<bool> updateChat(String chatId, Message m);
  Future<List<Chat>> getChatsByUser(String currentUserId);
  Future<bool> readChat(String chatId);
  Future<Message> getLastMessage(String chatId, String currentUserId);
}
