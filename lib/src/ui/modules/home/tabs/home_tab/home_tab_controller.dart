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

  List<Post> _postsFiltered = [];
  List<Post> get postsFiltered => _postsFiltered;

  List<String> _searchesList = [];
  List<String> get searchesList => _searchesList;

  List<bool> _likedPosts = [];
  List<bool> get likedPosts => _likedPosts;

  List<bool> _likedSearchs = [];
  List<bool> get likedSearch => _likedSearchs;

  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController get textFieldController => _textFieldController;

  String _searchText = "";
  String get searchText => _searchText;

  late User _user;

  final FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _user = await _usersRepository.getCurrentUser();

    _userPosts = await _postsRepository.getPosts(_user);
    _likedPosts = List.generate(_userPosts.length, (_) => false);

    for (int index = 0; index < _userPosts.length; index++) {
      _likedPosts[index] =
          await _usersRepository.isPostLiked(_userPosts[index].id);
    }

    _focusNode.addListener(_onSearchBarFocusChange);

    notifyListeners();
  }

  void _onSearchBarFocusChange() {
    if (_focusNode.hasFocus) {
      _searchesList.clear();

      for (dynamic search in _user.lastSearches) {
        _searchesList.add(search);
      }

      _likedSearchs = List.generate(_searchesList.length, (_) => false);

      for (int index = 0; index < _user.lastSearches.length; index++) {
        _likedSearchs[index] =
            _user.likedSearches.contains(_user.lastSearches[index]);
      }

      notifyListeners();
    }
  }

  void unFocusSearchBar() {
    _focusNode.unfocus();
    notifyListeners();
  }

  void postFavouriteClicked(String postId, int index) async {
    _likedPosts[index] = !_likedPosts[index];

    if (await _usersRepository.isPostLiked(postId)) {
      await _usersRepository.removePostLikedToUser(_user, postId);
      await _postsRepository.removeLikeToPost(postId);
    } else {
      await _usersRepository.addPostLikedToUser(_user, postId);
      await _postsRepository.addLikeToPost(postId);
    }

    notifyListeners();
  }

  void searchFavouriteClicked(String search, int index) async {
    _likedSearchs[index] = !_likedSearchs[index];

    if (_user.likedSearches.contains(search)) {
      _user.likedSearches.remove(search);
      await _usersRepository.updateLikedSearches(_user.likedSearches, _user);
    } else {
      _user.likedSearches.add(search);
      await _usersRepository.updateLikedSearches(_user.likedSearches, _user);
    }

    notifyListeners();
  }

  void onIsSearchTextChanged(String value) {
    _searchText = value;
    notifyListeners();
  }

  Future<bool> addNewSearchToDB(String text) async {
    if (text.isNotEmpty) {
      if (!_user.lastSearches.contains(text)) {
        _searchesList.add(text);
        notifyListeners();
        return await _usersRepository.updateLastSearches(_searchesList, _user);
      }
    }
    return true;
  }

  Future<bool> removeSearchToDB(String text) async {
    _searchesList.remove(text);
    notifyListeners();
    if (_user.likedSearches.remove(text)) {
      await _usersRepository.updateLikedSearches(_user.likedSearches, _user);
    }
    return await _usersRepository.updateLastSearches(_searchesList, _user);
  }

  Future<bool> removeAllSearchesList() async {
    _searchesList.clear();
    notifyListeners();
    return await _usersRepository.updateLastSearches([], _user);
  }

  Future<List<Post>> submit(String text) async {
    List<Post> allPosts = await _postsRepository.getPosts(_user);

    return allPosts
        .where((element) =>
            element.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  Future<List<Post>> onCategoryClicked(String category) async {
    List<Post> allPosts = await _postsRepository.getPosts(_user);

    return allPosts
        .where((element) => element.category.compareTo(category) == 0)
        .toList();
  }
}
