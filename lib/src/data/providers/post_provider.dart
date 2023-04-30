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
class PostProvider {
  Future<bool> addPost(Post newPost, User user) async {
    try {
      /// Insert the post image to database
      newPost.image = await FirebaseStorage.instance
          .ref(postBucket)
          .child(
            newPost.file.hashCode.toString(),
          )
          .putFile(
            newPost.file,
          )
          .then(
            (task) => task.ref.getDownloadURL(),
          );

      /// Add post to database
      await FirebaseFirestore.instance.collection(postStore).add(
            newPost.toMap(),
          );

      /// Add post to the user groups created list
      QuerySnapshot<Map<String, dynamic>> userRecord =
          await _getUserRecord(user);

      // user.postsCreated.add(newPost.id);

      // await FirebaseFirestore.instance
      //     .collection(userStore)
      //     .doc(userRecord.docs.first.id)
      //     .update({"groupsCreatedList": user.postsCreated});

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return false;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getUserRecord(User user) {
    return FirebaseFirestore.instance
        .collection(userStore)
        .where(
          id,
          isEqualTo: user.id,
        )
        .limit(1)
        .get();
  }
}
