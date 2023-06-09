import "package:wallapop/src/data/models/post.dart";

import "../models/review.dart";
import "../models/user.dart";

/// Abstract class that contains the necessary methods for the provider
abstract class UserRepository {
  Future<List<Post>> getPostsByUser(User user);
  Future<User> getUserByPostId(String postId);
  Future<bool> addPostLikedToUser(User user, String postId);
  Future<bool> removePostLikedToUser(User user, String postId);
  Future<User> getCurrentUser();
  Future<bool> isPostLiked(String postId);
  Future<User> getUserByReviewId(String reviewId);
  Future<List<User>> getFavouriteProfilesByUser(User user);
  Future<User> getUserById(String userId);
  Future<bool> updateUserStars(List<Review> reviews, User user);
  Future<bool> addPurchasedProduct(User user, String postId);
  Future<bool> addSoldedProduct(User user, String postId);
  Future<bool> updateLastSearches(List<dynamic> lastSearches, User user);
  Future<bool> updateLikedSearches(List<dynamic> likedSearches, User user);
  Future<bool> updateProfilesLiked(List<dynamic> profilesLiked, User user);
  Future<bool> deleteUserPost(String postId, User user);
  Future<bool> addViewedPost(User user, String postId);
  Future<bool> updateUser(String userId, User newUser);
}
