import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallapop/src/data/models/review.dart';

import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/data/providers/authentication_provider.dart';

import '../../helpers/get.dart';
import '../models/post.dart';

const String postStore = "post_store";
const String userStore = "user_store";
const String postBucket = "post_bucket";
const String idField = "id";
const String postsCreatedField = "postsCreated";
const String starsField = "stars";
const String reviewsCreatedField = "reviewsCreated";
const String productsPurchasedField = "productsPurchased";
const String productsSoldedField = "productsSolded";

/// Class that contains the provider methods logic
class UserProvider {
  Future<List<Post>> getPostsByUser(User user) async {
    List<Post> postsList = [];

    for (dynamic userPostId in user.postsCreated) {
      Post post = await getPostById(userPostId);
      if (!post.sold) {
        postsList.add(post);
      }
    }

    return postsList;
  }

  Future<Post> getPostById(dynamic userPostId) async {
    final record = await FirebaseFirestore.instance
        .collection(postStore)
        .where(
          idField,
          isEqualTo: userPostId,
        )
        .limit(1)
        .get();

    Map<String, dynamic> map = record.docs.first.data();

    return Post.fromMap(map);
  }

  Future<User> getUserByPostId(String postId) async {
    final record = await FirebaseFirestore.instance
        .collection(userStore)
        .where(
          postsCreatedField,
          arrayContains: postId,
        )
        .limit(1)
        .get();

    Map<String, dynamic> map = record.docs.first.data();

    return User.fromMap(map);
  }

  Future<bool> addPostLikedToUser(User user, String postId) async {
    try {
      user.postsLiked.add(postId);

      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(
            user.id,
          )
          .update(
        {"postsLiked": user.postsLiked},
      );

      Get.i.put<User>(user);

      return false;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    return true;
  }

  Future<bool> removePostLikedToUser(User user, String postId) async {
    try {
      user.postsLiked.remove(postId);

      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(
            user.id,
          )
          .update(
        {"postsLiked": user.postsLiked},
      );

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    return false;
  }

  Future<bool> isPostLiked(String postId) async {
    final User user = await getCurrentUser();

    return user.postsLiked.contains(postId);
  }

  Future<User> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final record = await FirebaseFirestore.instance
        .collection(userStore)
        .where(emailConstant, isEqualTo: prefs.getString(emailConstant))
        .limit(1)
        .get();

    return User.fromMap(record.docs.first.data());
  }

  Future<User> getUserByReviewId(String reviewId) async {
    final record = await FirebaseFirestore.instance
        .collection(userStore)
        .where(
          reviewsCreatedField,
          arrayContains: reviewId,
        )
        .limit(1)
        .get();

    Map<String, dynamic> map = record.docs.first.data();

    return User.fromMap(map);
  }

  Future<bool> updateUserStars(List<Review> reviews, User user) async {
    try {
      int totalStars = 0;

      for (Review r in reviews) {
        totalStars += r.stars;
      }

      int finalStars = (totalStars / reviews.length).round();

      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(
            user.id,
          )
          .update(
        {starsField: finalStars},
      );

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    return false;
  }

  Future<bool> addPurchasedProduct(User user, String postId) async {
    try {
      user.productsPurchased.add(postId);

      await _updateUserData(
          user.id, productsPurchasedField, user.productsPurchased);

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    return false;
  }

  Future<bool> addSoldedProduct(User user, String postId) async {
    try {
      user.productsSolded.add(postId);

      await _updateUserData(
        user.id,
        productsSoldedField,
        user.productsSolded,
      );

      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
    return false;
  }

  Future<bool> _updateUserData(
      String userId, String field, List<dynamic> newList) async {
    try {
      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(
            userId,
          )
          .update(
        {field: newList},
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  Future<bool> deleteUserPost(String postId, User user) async {
    try {
      user.postsCreated.remove(postId);

      await _updateUserData(
        user.id,
        postsCreatedField,
        user.postsCreated,
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }
}
