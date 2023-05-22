import 'package:wallapop/src/data/models/post.dart';

import '../data/models/user.dart';

class PurchaseReviewArguments {
  final Post post;
  final User user;

  PurchaseReviewArguments({
    required this.post,
    required this.user,
  });
}

class ChatArguments {
  final Post post;
  final User user;

  ChatArguments({
    required this.post,
    required this.user,
  });
}

class FilterPostsArguments {
  final List<Post> postsList;
  final String? category;
  final String searchText;

  FilterPostsArguments({
    required this.postsList,
    this.category,
    required this.searchText,
  });
}
