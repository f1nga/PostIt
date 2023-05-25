
import '../../utils/methods.dart';

class Chat {
  late String senderId, receiverId, postId, id = Methods.generateId();
  bool readed = false;
  late List<dynamic> messagesList;

  Chat({
    required this.senderId,
    required this.receiverId,
    required this.postId,
    required this.messagesList,
  });

  Chat.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    senderId = map["senderId"];
    receiverId = map["receiverId"];
    postId = map["postId"];
    messagesList = map["messagesList"];
    readed = map["readed"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "messagesList": messagesList,
      "readed": readed,
      "postId": postId,
    };
  }
}
