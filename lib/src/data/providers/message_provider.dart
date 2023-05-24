import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:wallapop/src/data/models/chat.dart';
import 'package:wallapop/src/data/models/user.dart';
import '../models/message.dart';
import '../models/messages.dart';
import '../models/post.dart';

const String messageStore = "message_store";
const String chatStore = "chat_store";
const String idField = "id";
const String receiverIdField = "receiverId";
const String senderIdField = "senderId";
const String postIdField = "postId";
const String dateField = "date";
const String readedField = "readed";
const String messagesListField = "messagesList";

class MessageProvider {
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
                chat.messagesList.add(Messages.fromMap(mess));
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

  Future<List<Message>> getMessages(
      String receiverId, String currentUserId) async {
    List<Message> messagesList = [];
    List<String> readedMessages = [];

    try {
      await FirebaseFirestore.instance
          .collection(messageStore)
          .where(receiverIdField, whereIn: [receiverId, currentUserId])
          .orderBy(dateField)
          .get()
          .then(
            (querySnapshot) {
              for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
                  in querySnapshot.docs) {
                Message message = Message.fromMap(documentSnapshot.data());
                if (message.senderId == currentUserId) {
                  message.sended = true;
                  messagesList.add(message);
                } else if (message.senderId == receiverId) {
                  message.sended = false;
                  message.readed = true;
                  readedMessages.add(message.id);
                  messagesList.add(message);
                }
              }
            },
          );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    for (String id in readedMessages) {
      await _readMessage(id);
    }

    return messagesList;
  }

  Future<bool> addMessage(Message newMessage) async {
    try {
      await FirebaseFirestore.instance
          .collection(messageStore)
          .doc(newMessage.id)
          .set(
            newMessage.toMap(),
          );

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return false;
    }
  }

  Future<bool> updateChat(String chatId, List<dynamic> messages) async {
    List<Map<String, dynamic>> messages1 = [
      {
        'id': '2231daddasasd',
        'senderId': 'usuario1',
        'content': 'Hola',
        'readed': false,
        'timestamp': DateTime.now(),
      },
      {
        'sender': 'usuario2',
        'content': 'Hola de vuelta',
        'id': '2231daddasasd',
        'readed': false,
        'timestamp': DateTime.now()
      },
      {
        'sender': 'usuario2',
        'content': 'vagibe',
        'id': '2231daddasasd',
        'readed': false,
        'timestamp': DateTime.now()
      },
    ];

    // List<Map<String, dynamic>> mapList = messages.map((item) {
    //   return {
    //     'senderId': item['senderId'],
    //     'content': item['content'],
    //     'id': item['id'],
    //     'readed': item['readed'],
    //     'timestamp': item['timestamp'],
    //   };
    // }).toList();

    try {
      await FirebaseFirestore.instance
          .collection(chatStore)
          .doc(chatId)
          .update({messagesListField: messages});

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

  Future<void> _readMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection(messageStore)
          .doc(messageId)
          .update({readedField: true});
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }
}
