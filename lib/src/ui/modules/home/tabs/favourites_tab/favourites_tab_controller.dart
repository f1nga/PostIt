import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../helpers/get.dart';

class FavouritesTabController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  List<Post> _userPosts = [];
  List<Post> get userPosts => _userPosts;
  List<bool> likedPosts = [];

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _userPosts = await _postsRepository.getFavouritePostsByUser(await _usersRepository.getCurrentUser());
    likedPosts = List.generate(_userPosts.length, (_) => false);

    for (int index = 0; index < _userPosts.length; index++) {
      likedPosts[index] =
          await _usersRepository.isPostLiked(_userPosts[index].id);
    }
    notifyListeners();
  }

  void postFavouriteClicked(String postId, int index) async {
    if (await _usersRepository.isPostLiked(postId)) {
      await _usersRepository.removePostLikedToUser(
          await _usersRepository.getCurrentUser(), postId);
      await _postsRepository.removeLikeToPost(postId);
    } else {
      await _usersRepository.addPostLikedToUser(
          await _usersRepository.getCurrentUser(), postId);
      await _postsRepository.addLikeToPost(postId);
    }

    likedPosts[index] = !likedPosts[index];
    notifyListeners();
  }
}
