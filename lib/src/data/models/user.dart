import 'dart:io';

import 'package:wallapop/src/utils/constants.dart';

import '../../utils/methods.dart';

class User {
  late String nickname, email, image, id = Methods.generateId();
  String? password;
  late List<dynamic> postsCreated;
  late File? file;
  late int stars, sales, purchases;

  User({
    required this.nickname,
    required this.email,
    this.password,
    this.postsCreated = const [],
    this.image = Constants.defaultProfileAvatar,
    this.file,
    this.stars = 0,
    this.sales = 0,
    this.purchases = 0,
  });

  /// A function that converts a Map to object User
  /// @param {Map<String, dynamic>}
  User.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nickname = map["nickname"];
    email = map["email"];
    password = map["password"];
    postsCreated = map["postsCreated"];
    image = map["image"];
    stars = map["stars"];
    purchases = map["purchases"];
    sales = map["sales"];
  }

  /// A function that convert a object User to a Map
  /// @returns {Map<String, dynamic>}
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "nickname": nickname,
      "email": email,
      "password": password,
      "postsCreated": postsCreated,
      "image": image,
      "stars": stars,
      "sales": sales,
      "purchases": purchases,
    };
  }
}
