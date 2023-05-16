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

  List<bool> _likedPosts = [];
  List<bool> get likedPosts => _likedPosts;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    notifyListeners();
  }

  void setPostsList(List<Post> postsList) async {
    _postsList = postsList;

    _likedPosts = List.generate(_postsList.length, (_) => false);

    for (int index = 0; index < _postsList.length; index++) {
      likedPosts[index] =
          await _usersRepository.isPostLiked(_postsList[index].id);
    }

    notifyListeners();
  }

  void postFavouriteClicked(String postId, int index) async {
    likedPosts[index] = !likedPosts[index];

    if (await _usersRepository.isPostLiked(postId)) {
      await _usersRepository.removePostLikedToUser(
          await _usersRepository.getCurrentUser(), postId);
      await _postsRepository.removeLikeToPost(postId);
    } else {
      await _usersRepository.addPostLikedToUser(
          await _usersRepository.getCurrentUser(), postId);
      await _postsRepository.addLikeToPost(postId);
    }

    notifyListeners();
  }

  void Function()? onDispose;
}
