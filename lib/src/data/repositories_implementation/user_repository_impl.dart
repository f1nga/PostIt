import 'package:wallapop/src/data/models/review.dart';
import 'package:wallapop/src/data/models/user.dart';

import 'package:wallapop/src/data/models/post.dart';

import '../providers/user_provider.dart';
import '../repositories/user_repository.dart';

/// Class that implements the provider obligatory methods
class UserRepositoryImpl implements UserRepository {
  final UserProvider _userProvider;

  UserRepositoryImpl(this._userProvider);

  @override
  Future<List<Post>> getPostsByUser(User user) {
    return _userProvider.getPostsByUser(user);
  }

  @override
  Future<User> getUserByPostId(String postId) {
    return _userProvider.getUserByPostId(postId);
  }

  @override
  Future<bool> addPostLikedToUser(User user, String postId) {
    return _userProvider.addPostLikedToUser(user, postId);
  }

  @override
  Future<User> getCurrentUser() {
    return _userProvider.getCurrentUser();
  }

  @override
  Future<bool> removePostLikedToUser(User user, String postId) {
    return _userProvider.removePostLikedToUser(user, postId);
  }

  @override
  Future<bool> isPostLiked(String postId) {
    return _userProvider.isPostLiked(postId);
  }

  @override
  Future<User> getUserByReviewId(String reviewId) {
    return _userProvider.getUserByReviewId(reviewId);
  }

  @override
  Future<bool> updateUserStars(List<Review> reviews, User user) {
    return _userProvider.updateUserStars(reviews, user);
  }
}
