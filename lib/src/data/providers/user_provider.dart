import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallapop/src/data/models/review.dart';

import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/data/providers/authentication_provider.dart';

import '../../helpers/get.dart';
import '../../utils/methods.dart';
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
const String lastSearchesField = "lastSearches";
const String likedSearchesField = "likedSearches";
const String profilesLikedField = "profilesLiked";
const String postsViewedField = "postsViewed";

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

  Future<List<User>> getFavouriteProfilesByUser(User user) async {
    List<User> usersList = [];

    try {
      await FirebaseFirestore.instance
          .collection(userStore)
          .where(idField, whereIn: user.profilesLiked)
          .get()
          .then(
        (querySnapshot) {
          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
              in querySnapshot.docs) {
            usersList.add(User.fromMap(documentSnapshot.data()));
          }
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return usersList;
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

  Future<User> getUserById(String userId) async {
    final record = await FirebaseFirestore.instance
        .collection(userStore)
        .where(
          idField,
          isEqualTo: userId,
        )
        .limit(1)
        .get();

    Map<String, dynamic> map = record.docs.first.data();

    return User.fromMap(map);
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

  Future<bool> addViewedPost(User user, String postId) async {
    try {
      user.postsViewed.add(postId);

      await _updateUserData(user.id, postsViewedField, user.postsViewed);

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

  Future<bool> updateUser(String userId, User newUser) async {
    try {
      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(userId)
          .delete();

      if (newUser.file != null) {
        newUser.image = await FirebaseStorage.instance
            .ref(usersBucket)
            .child(
              newUser.file.hashCode.toString(),
            )
            .putFile(
              newUser.file!,
            )
            .then(
              (task) => task.ref.getDownloadURL(),
            );
      }

      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(newUser.id)
          .set(
            newUser.toMap(),
          );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setString(token, Methods.generateToken().toString());
      prefs.setString(emailConstant, newUser.email);

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

  Future<bool> updateLastSearches(List<dynamic> lastSearches, User user) async {
    try {
      await _updateUserData(
        user.id,
        lastSearchesField,
        lastSearches,
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  Future<bool> updateLikedSearches(
      List<dynamic> likedSearches, User user) async {
    try {
      await _updateUserData(
        user.id,
        likedSearchesField,
        likedSearches,
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  Future<bool> updateProfilesLiked(
      List<dynamic> profilesLiked, User user) async {
    try {
      await _updateUserData(
        user.id,
        profilesLikedField,
        profilesLiked,
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
