// ignore_for_file: unused_import

import 'package:wallapop/src/data/models/review.dart';
import 'package:wallapop/src/data/models/user.dart';

import '../providers/review_provider.dart';
import '../providers/user_provider.dart';
import '../repositories/review_repository.dart';

/// Class that implements the provider obligatory methods
class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewProvider _reviewProvider;

  ReviewRepositoryImpl(this._reviewProvider);

  @override
  Future<bool> addReview(Review review, User currentUser) {
    return _reviewProvider.addReview(review, currentUser);
  }

  @override
  Future<List<Review>> getReviewsByUser(User user) {
    return _reviewProvider.getReviewsByUser(user);
  }
}
