import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../helpers/get.dart';
import '../models/post.dart';

const String postStore = "post_store";
const String userStore = "user_store";
const String postBucket = "post_bucket";
const String idField = "id";
const String postsCreatedField = "postsCreated";
const String likesField = "likes";
const String soldField = "sold";

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
      await FirebaseFirestore.instance
          .collection(postStore)
          .doc(newPost.id)
          .set(
            newPost.toMap(),
          );

      user.postsCreated.add(newPost.id);

      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(user.id)
          .update({
        postsCreatedField: user.postsCreated,
      });

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return false;
    }
  }

  Future<List<Post>> getPosts(User user) async {
    List<Post> postsList = [];

    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .where(idField, whereNotIn: user.postsCreated)
          .get()
          .then(
        (querySnapshot) {
          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
              in querySnapshot.docs) {
            if (!documentSnapshot.get("sold")) {
              postsList.add(Post.fromMap(documentSnapshot.data()));
            }
          }
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return postsList;
  }

  Future<List<Post>> getFavouritePostsByUser(User user) async {
    List<Post> postsList = [];

    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .where(idField, whereIn: user.postsLiked)
          .get()
          .then(
        (querySnapshot) {
          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
              in querySnapshot.docs) {
            postsList.add(Post.fromMap(documentSnapshot.data()));
          }
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return postsList;
  }

  Future<bool> addLikeToPost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .doc(
            postId,
          )
          .update(
        {likesField: FieldValue.increment(1)},
      );

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    return false;
  }

  Future<bool> removeLikeToPost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .doc(
            postId,
          )
          .update(
        {likesField: FieldValue.increment(-1)},
      );

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    return false;
  }

  Future<Post> getPostByReviewId(String reviewId) async {
    late Post post;

    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .where(idField, isEqualTo: reviewId)
          .get()
          .then(
        (querySnapshot) {
          post = Post.fromMap(querySnapshot.docs.first.data());
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return post;
  }
}
