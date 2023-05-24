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
  Future<User> getUserById(String userId) {
    return _userProvider.getUserById(userId);
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

  @override
  Future<bool> addPurchasedProduct(User user, String postId) {
    return _userProvider.addPurchasedProduct(user, postId);
  }

  @override
  Future<bool> addSoldedProduct(User user, String postId) {
    return _userProvider.addSoldedProduct(user, postId);
  }

  @override
  Future<bool> deleteUserPost(String postId, User user) {
    return _userProvider.deleteUserPost(postId, user);
  }

  @override
  Future<bool> updateLastSearches(List lastSearches, User user) {
    return _userProvider.updateLastSearches(lastSearches, user);
  }

  @override
  Future<bool> updateLikedSearches(List likedSearches, User user) {
    return _userProvider.updateLikedSearches(likedSearches, user);
  }

  @override
  Future<bool> updateProfilesLiked(List profilesLiked, User user) {
    return _userProvider.updateProfilesLiked(profilesLiked, user);
  }

  @override
  Future<List<User>> getFavouriteProfilesByUser(User user) {
    return _userProvider.getFavouriteProfilesByUser(user);
  }

  @override
  Future<bool> addViewedPost(User user, String postId) {
    return _userProvider.addViewedPost(user, postId);
  }

  @override
  Future<bool> updateUser(String userId, User newUser) {
    return _userProvider.updateUser(userId, newUser);
  }
}
