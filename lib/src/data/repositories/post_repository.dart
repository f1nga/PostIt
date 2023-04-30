import "package:wallapop/src/data/models/post.dart";

import "../models/user.dart";

/// Abstract class that contains the necessary methods for the provider
abstract class PostRepository {
  Future<bool> addPost(Post post, User user);
}
