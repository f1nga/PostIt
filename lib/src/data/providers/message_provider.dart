import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:wallapop/src/data/models/user.dart';
import '../models/message.dart';
import '../models/post.dart';

const String messageStore = "message_store";
const String idField = "id";
const String receiverIdField = "receiverId";
const String senderIdField = "senderId";
const String dateField = "date";
const String readedField = "readed";

class MessageProvider {
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
