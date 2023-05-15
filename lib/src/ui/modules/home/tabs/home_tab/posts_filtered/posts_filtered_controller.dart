import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';
import 'package:wallapop/src/helpers/get.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../data/models/user.dart';
import '../../../../../../data/repositories/post_repository.dart';

class PostsFilteredController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  List<Post> _postsList = [];
  List<Post> get postsList => _postsList;

  List<User> _userCreatedPosts = [];
  List<User> get userCreatedPosts => _userCreatedPosts;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    notifyListeners();
  }

  void setPostsList(List<Post> postsList) {
    _postsList = postsList;
    notifyListeners();
  }

  void Function()? onDispose;
}
