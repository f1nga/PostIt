import "package:wallapop/src/data/models/post.dart";

import "../models/user.dart";

/// Abstract class that contains the necessary methods for the provider
abstract class PostRepository {
  Future<bool> addPost(Post post, User user);
  Future<List<Post>> getPosts(User user);
  Future<bool> addLikeToPost(String publicationId);
  Future<bool> removeLikeToPost(String postId);
  Future<List<Post>> getFavouritePostsByUser(User user);
  Future<Post> getPostByReviewId(String reviewId);
  Future<bool> soldProduct(String postId);
  Future<List<Post>> getPurchasedPostsByUser(User user);
}
