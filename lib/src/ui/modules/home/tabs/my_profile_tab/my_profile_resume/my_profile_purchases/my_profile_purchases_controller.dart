import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../../../data/models/post.dart';
import '../../../../../../../data/models/user.dart';
import '../../../../../../../data/repositories/post_repository.dart';
import '../../../../../../../helpers/get.dart';

class MyProfilePurchasesController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  List<Post> _userPurchasedPosts = [];
  List<Post> get userPurchasedPosts => _userPurchasedPosts;

  List<User> _userCreatedPosts = [];
  List<User> get userCreatedPosts => _userCreatedPosts;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _userPurchasedPosts = await _postsRepository
        .getPurchasedPostsByUser(await _usersRepository.getCurrentUser());

    for (Post post in _userPurchasedPosts) {
      _userCreatedPosts.add(await _usersRepository.getUserByPostId(post.id));
    }
    notifyListeners();
  }

  void Function()? onDispose;
}
