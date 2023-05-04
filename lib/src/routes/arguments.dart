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
