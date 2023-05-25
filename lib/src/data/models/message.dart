import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/methods.dart';

class Message {
  late String senderId, content, id = Methods.generateId();
  bool readed = false, sended = true;
  Timestamp date = Timestamp.now();

  Message({
    required this.senderId,
    required this.content,
  });

  Message.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    senderId = map["senderId"];
    content = map["content"];
    readed = map["readed"];
    date = map["date"];
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
