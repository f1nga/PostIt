import 'package:flutter/material.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/utils/methods.dart';

import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../../../helpers/get.dart';

class PostDetailController extends ChangeNotifier {
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;

  User? user;
  late User _currentUser;
  User get currentUser => _currentUser;
  bool isLoading = false;
  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _currentUser = await _usersRepository.getCurrentUser();
    notifyListeners();
  }

  String getLastEditedDate(DateTime date) {
    return Methods.getLastEditedDate(date);
  }

  Future<void> onIsLikedPressed(String postId) async {
    _isLiked = !_isLiked;

    if (await _usersRepository.isPostLiked(postId)) {
      await _usersRepository.removePostLikedToUser(_currentUser, postId);
      await _postsRepository.removeLikeToPost(postId);
    } else {
      await _usersRepository.addPostLikedToUser(_currentUser, postId);
      await _postsRepository.addLikeToPost(postId);
    }

    notifyListeners();
  }

  Future<bool> buyProduct(String postId) async {
    return await _usersRepository.addPurchasedProduct(currentUser, postId) &&
        await _postsRepository.soldProduct(postId) &&
        await _usersRepository.addSoldedProduct(user!, postId) &&
        await _usersRepository.removePostLikedToUser(currentUser, postId);
  }

  void isPostLiked(String postId) async {
    _isLiked = await _usersRepository.isPostLiked(postId);
    notifyListeners();
  }

  void getUserByPostId(String postId) async {
    isLoading = true;
    notifyListeners();

    user = await _usersRepository.getUserByPostId(postId);

    isLoading = false;
    notifyListeners();
  }
}
