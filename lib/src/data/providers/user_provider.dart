import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:wallapop/src/data/models/user.dart';

import '../models/post.dart';

const String postStore = "post_store";
const String userStore = "user_store";
const String postBucket = "post_bucket";
const String id = "id";

/// Class that contains the provider methods logic
class UserProvider {
  Future<List<Post>> getPostsByUser(User user) async {
    List<Post> postsList = [];

    for (dynamic userPostId in user.postsCreated) {
      Post c = await getPostById(userPostId);
      postsList.add(c);
    }

    return postsList;
  }

  Future<Post> getPostById(dynamic userPostId) async {
    final record = await FirebaseFirestore.instance
        .collection(postStore)
        .where(
          id,
          isEqualTo: userPostId,
        )
        .limit(1)
        .get();

    Map<String, dynamic> map = record.docs.first.data();

    return Post.fromMap(map);
  }
}
