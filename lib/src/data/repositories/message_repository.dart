import "package:wallapop/src/data/models/message.dart";
import "package:wallapop/src/data/models/post.dart";

import "../models/review.dart";
import "../models/user.dart";

/// Abstract class that contains the necessary methods for the provider
abstract class MessageRepository {
  Future<List<Message>> getMessages(String receiverId, String senderId);
  Future<bool> addMessage(Message newMessage);
}
