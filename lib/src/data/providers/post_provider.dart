import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:wallapop/src/data/models/user.dart';
import '../models/post.dart';

const String postStore = "post_store";
const String userStore = "user_store";
const String postBucket = "post_bucket";
const String idField = "id";
const String postsCreatedField = "postsCreated";
const String likesField = "likes";
const String soldField = "sold";
const String titleField = "title";
const String viewsField = "views";

/// Class that contains the provider methods logic
class PostProvider {
  Future<bool> addPost(Post newPost, User user) async {
    try {
      /// Insert the post image to database

      for (File? file in newPost.filesList) {
        if (file != null) {
          final String image = await FirebaseStorage.instance
              .ref(postBucket)
              .child(
                file.hashCode.toString(),
              )
              .putFile(
                file,
              )
              .then(
                (task) => task.ref.getDownloadURL(),
              );

          newPost.imagesList.add(image);
        }
      }

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
    if (user.postsCreated.isEmpty) user.postsCreated.add("");

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

  Future<List<Post>> getPurchasedPostsByUser(User user) async {
    List<Post> postsList = [];

    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .where(idField, whereIn: user.productsPurchased)
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

  Future<List<Post>> getSalesPostsByUser(User user) async {
    List<Post> postsList = [];

    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .where(idField, whereIn: user.productsSolded)
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

  Future<List<Post>> getPostsByText(String text) async {
    List<Post> postsList = [];

    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .where(titleField, arrayContains: text)
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

  Future<bool> addViewToPost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .doc(
            postId,
          )
          .update(
        {viewsField: FieldValue.increment(1)},
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

  Future<bool> soldProduct(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .doc(
            postId,
          )
          .update(
        {soldField: true},
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  Future<bool> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection(postStore)
          .doc(postId)
          .delete();

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }
}
