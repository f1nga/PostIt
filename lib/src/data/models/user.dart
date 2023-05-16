import 'dart:io';
import 'dart:math';

import 'package:wallapop/src/utils/constants.dart';

import '../../utils/methods.dart';

class User {
  late String nickname, email, image, id = Methods.generateId();
  String? password;
  late List<dynamic> postsCreated = [],
      postsLiked = [],
      reviewsCreated = [],
      productsPurchased = [],
      productsSolded = [],
      lastSearches = [],
      likedSearches = [],
      profilesLiked = [];
  late File? file;
  late int stars = 0;

  User({
    required this.nickname,
    required this.email,
    this.password,
    this.image = Constants.defaultProfileAvatar,
    this.file,
  });

  /// A function that converts a Map to object User
  /// @param {Map<String, dynamic>}
  User.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nickname = map["nickname"];
    email = map["email"];
    password = map["password"];
    postsCreated = map["postsCreated"];
    postsLiked = map["postsLiked"];
    reviewsCreated = map["reviewsCreated"];
    productsPurchased = map["productsPurchased"];
    productsSolded = map["productsSolded"];
    lastSearches = map["lastSearches"];
    likedSearches = map["likedSearches"];
    profilesLiked = map["profilesLiked"];
    image = map["image"];
    stars = map["stars"];
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
      "postsLiked": postsLiked,
      "reviewsCreated": reviewsCreated,
      "productsPurchased": productsPurchased,
      "productsSolded": productsSolded,
      "lastSearches": lastSearches,
      "likedSearches": likedSearches,
      "profilesLiked": profilesLiked,
      "image": image,
      "stars": stars,
    };
  }
}
