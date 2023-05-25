import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:wallapop/src/data/models/chat.dart';
import '../models/message.dart';

const String messageStore = "message_store";
const String chatStore = "chat_store";
const String idField = "id";
const String receiverIdField = "receiverId";
const String senderIdField = "senderId";
const String postIdField = "postId";
const String dateField = "date";
const String readedField = "readed";
const String messagesListField = "messagesList";

class ChatProvider {
  Future<Chat?> isChatExists(
      String receiverId, String senderId, String postId) async {
    Chat? chatFound;

    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .where(receiverIdField, whereIn: [receiverId, senderId])
          .get()
          .then(
            (querySnapshot) {
              Chat chat = Chat.fromMap(querySnapshot.docs.first.data());
              for (var mess
                  in querySnapshot.docs.first.get(messagesListField)) {
                chat.messagesList.add(Message.fromMap(mess));
              }
              if (chat.senderId == senderId || chat.senderId == receiverId) {
                if (chat.postId == postId) {
                  chatFound = chat;
                }
              }
            },
          );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return chatFound;
  }

  Future<List<Chat>> getChatsByUser(String currentUserId) async {
    List<Chat> chatsList = [];
    try {
      await FirebaseFirestore.instance.collection(chatStore).get().then(
        (querySnapshot) {
          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
              in querySnapshot.docs) {
            Chat chat = Chat.fromMap(documentSnapshot.data());

            if (chat.senderId == currentUserId ||
                chat.receiverId == currentUserId) {
              for (var mess in documentSnapshot.get(messagesListField)) {
                chat.messagesList.add(Message.fromMap(mess));
              }
              chatsList.add(chat);
            }
          }
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return chatsList;
  }

  Future<List<Message>> getMessages(String chatId, String currentUserId) async {
    List<Message> messagesList = [];
    List<String> readedMessages = [];

    bool readChat = false;

    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .where(idField, isEqualTo: chatId)
          .get()
          .then(
        (querySnapshot) {
          for (var element in querySnapshot.docs.first.get(messagesListField)) {
            Message message = Message.fromMap(element);
            if (message.senderId == currentUserId) {
              message.sended = true;
              readChat = true;
            } else {
              message.sended = false;
              message.readed = true;
              readedMessages.add(message.id);
            }

            messagesList.add(message);
          }
        },
      );
      if (readChat) {
        await FirebaseFirestore.instance
            .collection(chatStore)
            .doc(chatId)
            .update({readedField: true});
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    final list = [];
    for (var element in messagesList) {
      list.add(element.toMap());
    }

    _readMessage(chatId, list);

    return messagesList;
  }

  Future<Message> getLastMessage(String chatId, String currentUserId) async {
    late Message lastMessage;

    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .where(idField, isEqualTo: chatId)
          .get()
          .then(
        (querySnapshot) {
          for (var element in querySnapshot.docs.first.get(messagesListField)) {
            Message message = Message.fromMap(element);
            if (message.senderId == currentUserId) {
              message.sended = true;
              message.readed = true;
            } else {
              message.sended = false;
            }

            lastMessage = message;
          }
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return lastMessage;
  }

  Future<bool> updateChat(String chatId, Message m) async {
    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .doc(chatId)
          .update({
        messagesListField: FieldValue.arrayUnion([m.toMap()])
      });

      await FirebaseFirestore.instance
          .collection(chatStore)
          .doc(chatId)
          .update({readedField: false});

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return false;
    }
  }

  Future<bool> addChat(Chat newChat) async {
    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .doc(newChat.id)
          .set(
            newChat.toMap(),
          );

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return false;
    }
  }

  Future<void> _readMessage(String chatId, List hol) async {
    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .doc(chatId)
          .update({messagesListField: hol});
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  Future<bool> readChat(String chatId) async {
    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .doc(chatId)
          .update({readedField: true});

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return false;
  }
}
