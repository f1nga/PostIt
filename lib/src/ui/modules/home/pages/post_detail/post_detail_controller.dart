import 'package:flutter/material.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';

import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../../../helpers/get.dart';

class PostDetailController extends ChangeNotifier {
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;

  User? user;
  bool isLoading = false;
  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    notifyListeners();
  }

  Future<void> onIsLikedPressed(String postId) async {
    _isLiked = !_isLiked;
    if (_isLiked) {
      await _usersRepository.addPostLikedToUser(
          await _usersRepository.getCurrentUser(), postId);
      await _postsRepository.addLikeToPost(postId);
    } else {
      await _usersRepository.removePostLikedToUser(
          await _usersRepository.getCurrentUser(), postId);
      await _postsRepository.removeLikeToPost(postId);
    }

    notifyListeners();
  }

  void isPostLiked(String postId) async {
    _isLiked = await _usersRepository.isPostLiked(postId);
  }

  void getUserByPostId(String postId) async {
    isLoading = true;
    notifyListeners();

    user = await _usersRepository.getUserByPostId(postId);

    isLoading = false;
    notifyListeners();
  }
}
