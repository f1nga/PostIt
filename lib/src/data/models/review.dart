import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallapop/src/utils/methods.dart';

class Review {
  late int stars;
  late String email, description, postId, id = Methods.generateId();
  late Timestamp date = Timestamp.now();

  Review({
    required this.email,
    this.description = "",
    required this.stars,
    required this.postId,
  });

  Review.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    description = map["description"];
    email = map["email"];
    stars = map["stars"];
    postId = map["postId"];
    date = map["date"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "description": description,
      "email": email,
      "stars": stars,
      "postId": postId,
      "date": date,
    };
  }
}
