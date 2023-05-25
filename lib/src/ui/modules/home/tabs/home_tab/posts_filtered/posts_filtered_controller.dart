import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';
import 'package:wallapop/src/helpers/get.dart';
import 'package:wallapop/src/routes/arguments.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../data/models/user.dart';
import '../../../../../../data/repositories/post_repository.dart';

class PostsFilteredController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  late User _user;

  List<Post> _postsList = [];
  List<Post> get postsList => _postsList;

  List<bool> _likedPosts = [];
  List<bool> get likedPosts => _likedPosts;

  String? _filterCategory;
  String? get filterCategory => _filterCategory;

  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController get textFieldController => _textFieldController;

  final FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;

  String _searchText = "";
  String get searchText => _searchText;

  List<bool> _likedSearchs = [];
  List<bool> get likedSearch => _likedSearchs;

  bool _isSearchLiked = false;
  bool get isSearchLiked => _isSearchLiked;

  final List<String> _searchesList = [];
  List<String> get searchesList => _searchesList;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _user = await _usersRepository.getCurrentUser();
    _focusNode.addListener(_onSearchBarFocusChange);

    notifyListeners();
  }

  void setArguments(FilterPostsArguments args) async {
    _postsList = args.postsList;

    _likedPosts = List.generate(_postsList.length, (_) => false);

    for (int index = 0; index < _postsList.length; index++) {
      likedPosts[index] =
          await _usersRepository.isPostLiked(_postsList[index].id);
    }

    _filterCategory = args.category;

    _textFieldController.text = args.searchText;

    final currentUser = await _usersRepository.getCurrentUser();

    _isSearchLiked = currentUser.likedSearches.contains(args.searchText);

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

  void searchFavouriteClicked(String search, int? index) async {
    index != null
        ? _likedSearchs[index] = !_likedSearchs[index]
        : _isSearchLiked = !_isSearchLiked;

    if (!_isSearchLiked) {
      _user.likedSearches.remove(search);
      await _usersRepository.updateLikedSearches(_user.likedSearches, _user);
    } else {
      _user.likedSearches.add(search);
      await _usersRepository.updateLikedSearches(_user.likedSearches, _user);
    }

    notifyListeners();
  }

  void unFocusSearchBar() {
    _focusNode.unfocus();
    notifyListeners();
  }

  void onIsSearchTextChanged(String value) {
    _searchText = value;
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

    if (_filterCategory != null) {
      return allPosts
          .where((element) =>
              element.category.compareTo(_filterCategory!) == 0 &&
              element.title.toLowerCase().contains(text))
          .toList();
    }

    return allPosts
        .where((element) =>
            element.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  void Function()? onDispose;
}
