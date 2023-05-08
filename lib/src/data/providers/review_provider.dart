import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:wallapop/src/data/models/review.dart';
import 'package:wallapop/src/data/models/user.dart';

const String reviewStore = "review_store";
const String userStore = "user_store";
const String idField = "id";
const String emailField = "email";
const String reviewsCreatedField = "reviewsCreated";
const String dateField = "date";

/// Class that contains the provider methods logic
class ReviewProvider {
  Future<bool> addReview(Review review, User currentUser) async {
    try {
      await FirebaseFirestore.instance
          .collection(reviewStore)
          .doc(review.id)
          .set(
            review.toMap(),
          );

      currentUser.reviewsCreated.add(review.id);

      await FirebaseFirestore.instance
          .collection(userStore)
          .doc(currentUser.id)
          .update({
        reviewsCreatedField: currentUser.reviewsCreated,
      });

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  Future<List<Review>> getReviewsByUser(User user) async {
    List<Review> reviewsList = [];

    try {
      await FirebaseFirestore.instance
          .collection(reviewStore)
          .where(emailField, isEqualTo: user.email)
          .orderBy(dateField, descending: true)
          .get()
          .then(
        (querySnapshot) {
          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
              in querySnapshot.docs) {
            reviewsList.add(Review.fromMap(documentSnapshot.data()));
          }
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return reviewsList;
  }
}
