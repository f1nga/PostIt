import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/methods.dart';

class Post {
  late String title, description, category, state, id = Methods.generateId();
  late double price;
  late int likes, views = 0;
  late Timestamp date = Timestamp.now();
  late bool sold = false;
  late List<File?> filesList;
  late List<dynamic> imagesList = [];

  Post({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.state,
    required this.filesList,
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
    imagesList = map["imagesList"];
    likes = map["likes"];
    views = map["views"];
    date = map["date"];
    sold = map["sold"];
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
      "imagesList": imagesList,
      "likes": likes,
      "views": views,
      "date": date,
      "sold": sold,
    };
  }
}
