import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../../../data/models/post.dart';
import '../../../../../../../data/models/user.dart';
import '../../../../../../../data/repositories/post_repository.dart';
import '../../../../../../../helpers/get.dart';

class MyProfileSalesController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  List<Post> _userSalesPosts = [];
  List<Post> get userSalesPosts => _userSalesPosts;

  List<User> _userCreatedPosts = [];
  List<User> get userCreatedPosts => _userCreatedPosts;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _userSalesPosts = await _postsRepository
        .getSalesPostsByUser(await _usersRepository.getCurrentUser());

    for (Post post in _userSalesPosts) {
      _userCreatedPosts.add(await _usersRepository.getUserByPostId(post.id));
    }
    notifyListeners();
  }

  void Function()? onDispose;
}
