import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/data/providers/post_provider.dart';

import '../repositories/post_repository.dart';

/// Class that implements the provider obligatory methods
class PostRepositoryImpl implements PostRepository {
  final PostProvider _postProvider;

  PostRepositoryImpl(this._postProvider);

  @override
  Future<bool> addPost(Post post, User user) {
    return _postProvider.addPost(post, user);
  }

  @override
  Future<List<Post>> getPosts(User user) {
    return _postProvider.getPosts(user);
  }

  @override
  Future<bool> addLikeToPost(String postId) {
    return _postProvider.addLikeToPost(postId);
  }

  @override
  Future<bool> removeLikeToPost(String postId) {
    return _postProvider.removeLikeToPost(postId);
  }

  @override
  Future<List<Post>> getFavouritePostsByUser(User user) {
    return _postProvider.getFavouritePostsByUser(user);
  }

  @override
  Future<Post> getPostByReviewId(String reviewId) {
    return _postProvider.getPostByReviewId(reviewId);
  }

  @override
  Future<bool> soldProduct(String postId) {
    return _postProvider.soldProduct(postId);
  }

  @override
  Future<List<Post>> getPurchasedPostsByUser(User user) {
    return _postProvider.getPurchasedPostsByUser(user);
  }
}
