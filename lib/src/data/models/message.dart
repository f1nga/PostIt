import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/methods.dart';

class Message {
  late String senderId, receiverId, content, id = Methods.generateId();
  late bool sended = true, readed = false;
  late Timestamp date = Timestamp.now();

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
  });

  Message.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    senderId = map["senderId"];
    receiverId = map["receiverId"];
    content = map["content"];
    readed = map["readed"];
    date = map["date"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
      "readed": readed,
      "date": date,
    };
  }
}
