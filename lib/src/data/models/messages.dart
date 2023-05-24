import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/methods.dart';

class Messages {
  late String senderId, content, id = Methods.generateId();
  bool readed = false;
  Timestamp date = Timestamp.now();

  Messages({
    required this.senderId,
    required this.content,
  });

  Messages.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    senderId = map["senderId"];
    date = map["date"];
    content = map["content"];
    readed = map["readed"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "senderId": senderId,
      "content": content,
      "readed": readed,
      "date": date,
    };
  }
}
