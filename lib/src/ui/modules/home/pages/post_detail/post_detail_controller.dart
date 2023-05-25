import 'package:flutter/material.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/utils/methods.dart';

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

  int _postLikes = 0;
  int get postLikes => _postLikes;

  int _postViews = 0;
  int get postViews => _postViews;

  bool _isProfileLiked = false;
  bool get isProfileLiked => _isProfileLiked;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _currentUser = await _usersRepository.getCurrentUser();

    notifyListeners();
  }

  void isPostViewed(String postId) async {
    final currentUser = await _usersRepository.getCurrentUser();

    if (!currentUser.postsViewed.contains(postId)) {
      // _postViews++;
      await _usersRepository.addViewedPost(currentUser, postId);
      await _postsRepository.addViewToPost(postId);
      notifyListeners();
    }
  }

  void setPostLikes(int value) {
    _postLikes = value;
    notifyListeners();
  }

  void setPostViews(int value) {
    _postViews = value;
    notifyListeners();
  }

  String getLastEditedDate(DateTime date) {
    return Methods.getLastEditedDate(date);
  }

  Future<void> onIsLikedPressed(String postId) async {
    _isLiked = !_isLiked;

    if (!_isLiked) {
      await _usersRepository.removePostLikedToUser(_currentUser, postId);
      await _postsRepository.removeLikeToPost(postId);
    } else {
      await _usersRepository.addPostLikedToUser(_currentUser, postId);
      await _postsRepository.addLikeToPost(postId);
    }

    notifyListeners();
  }

  Future<void> onIsProfileLikePressed(String userId) async {
    _isProfileLiked = !_isProfileLiked;

    _isProfileLiked
        ? _currentUser.profilesLiked.add(userId)
        : _currentUser.profilesLiked.remove(userId);

    await _usersRepository.updateProfilesLiked(
        _currentUser.profilesLiked, _currentUser);

    notifyListeners();
  }

  Future<bool> buyProduct(String postId) async {
    return await _usersRepository.addPurchasedProduct(currentUser, postId) &&
        await _postsRepository.soldProduct(postId) &&
        await _usersRepository.addSoldedProduct(user!, postId) &&
        await _usersRepository.removePostLikedToUser(currentUser, postId);
  }

  void onIsPostLiked(String postId) async {
    _isLiked = await _usersRepository.isPostLiked(postId);

    notifyListeners();
  }

  void onIsProfileLiked(String postId) async {
    final currentUser = await _usersRepository.getCurrentUser();
    final user2 = await _usersRepository.getUserByPostId(postId);

    _isProfileLiked = currentUser.profilesLiked.contains(user2.id);
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
