import 'dart:io';

import '../../utils/methods.dart';

class Post {
  late String
      title,
      description,
      category,
      state,
      image,
      id = Methods.generateId();
  late double price;
  late File file;

  Post({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.state,
    required this.file,
    this.image = ""
  });

  /// A function that converts a Map to object Post
  /// @param {Map<String, dynamic>}
  Post.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    price = map["price"];
    category = map["category"];
    state = map["state"];
    image = map["image"];
  }

  /// A function that convert a object Post to a Map
  /// @returns {Map<String, dynamic>}
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "category": category,
      "state": state,
      "image": image
    };
  }
}
