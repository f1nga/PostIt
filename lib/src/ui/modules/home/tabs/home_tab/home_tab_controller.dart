import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../data/models/post.dart';
import '../../../../../data/models/user.dart';
import '../../../../../helpers/get.dart';

class HomeTabController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  List<Post> _userPosts = [];
  List<Post> get userPosts => _userPosts;

  List<bool> likedPosts = [];

  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController get textFieldController => _textFieldController;

  String _searchText = "";
  String get searchText => _searchText;

  final FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;

  List<Post> _filteredPostsList = [];
  List<Post> get filteredPostsList => _filteredPostsList;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _userPosts = await _postsRepository
        .getPosts(await _usersRepository.getCurrentUser());
    likedPosts = List.generate(_userPosts.length, (_) => false);

    for (int index = 0; index < _userPosts.length; index++) {
      likedPosts[index] =
          await _usersRepository.isPostLiked(_userPosts[index].id);
    }

    _focusNode.addListener(_onSearchBarFocusChange);

    notifyListeners();
  }

  void _onSearchBarFocusChange() {
    if (_focusNode.hasFocus) {
      // Se hizo foco en el campo de entrada
      print('Campo de entrada con foco');
      print("hoool2 ${_focusNode.hasFocus}");
      notifyListeners();
    } else {
      // Se perdió el foco en el campo de entrada
      print('Campo de entrada sin foco');
      print("hoool1 ${_focusNode.hasFocus}");
      notifyListeners();
    }

    notifyListeners();
  }

  void unFocusSearchBar() {
    _focusNode.unfocus();
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

  void onIsSearchTextChanged(String value) {
    _searchText = value;
  }

  void submit(String text) async {
    _filteredPostsList = await _postsRepository
        .getPosts(await _usersRepository.getCurrentUser());

    List<Post> finalList = [];

    for (Post p in _filteredPostsList) {
      if (p.title.contains(text)) {
        finalList.add(p);
      }
    }

    _filteredPostsList = finalList;
    notifyListeners();
  }
}
