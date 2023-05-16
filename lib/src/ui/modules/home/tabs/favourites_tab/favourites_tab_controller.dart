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

  late User _user;

  List<Post> _userPosts = [];
  List<Post> get userPosts => _userPosts;

  List<bool> _likedPosts = [];
  List<bool> get likedPosts => _likedPosts;

  List<String> _userSearches = [];
  List<String> get userSearches => _userSearches;

  List<bool> _likedSearches = [];
  List<bool> get likedSearches => _likedSearches;

  List<User> _userProfiles = [];
  List<User> get userProfiles => _userProfiles;

  List<bool> _likedProfiles = [];
  List<bool> get likedProfiles => _likedProfiles;

  bool _isFavouritesProductsClicked = true;
  bool get isFavouritesProductsClicked => _isFavouritesProductsClicked;

  bool _isFavouritesSearchesClicked = false;
  bool get isFavouritesSearchesClicked => _isFavouritesSearchesClicked;

  bool _isFavouritesProfilesClicked = false;
  bool get isFavouritesProfilesClicked => _isFavouritesProfilesClicked;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _user = await _usersRepository.getCurrentUser();

    _userPosts = await _postsRepository.getFavouritePostsByUser(_user);
    _likedPosts = List.generate(_userPosts.length, (_) => true);

    for (String search in _user.likedSearches) {
      _userSearches.add(search);
    }
    _likedSearches = List.generate(_userSearches.length, (_) => true);

    _userProfiles = await _usersRepository.getFavouriteProfilesByUser(_user);
    _likedProfiles = List.generate(_userProfiles.length, (_) => true);

    notifyListeners();
  }

  void postFavouriteClicked(String postId, int index) async {
    if (await _usersRepository.isPostLiked(postId)) {
      await _usersRepository.removePostLikedToUser(_user, postId);
      await _postsRepository.removeLikeToPost(postId);
    } else {
      await _usersRepository.addPostLikedToUser(_user, postId);
      await _postsRepository.addLikeToPost(postId);
    }

    _likedSearches[index] = !_likedSearches[index];
    notifyListeners();
  }

  void searchFavouriteClicked(String search, int index) async {
    _likedSearches[index] = !_likedSearches[index];

    if (_likedSearches[index]) {
      _user.likedSearches.add(search);
      await _usersRepository.updateLikedSearches(_user.likedSearches, _user);
    } else {
      _user.likedSearches.remove(search);
      await _usersRepository.updateLikedSearches(_user.likedSearches, _user);
    }

    notifyListeners();
  }

  void profileFavouriteClicked(int index) async {
    _likedProfiles[index] = !_likedProfiles[index];

    _likedProfiles[index]
        ? _user.profilesLiked.add(userProfiles[index].id)
        : _user.profilesLiked.remove(userProfiles[index].id);

    await _usersRepository.updateProfilesLiked(_user.profilesLiked, _user);

    notifyListeners();
  }

  Future<List<Post>> onIsSearchClicked(String text) async {
    List<Post> allPosts = await _postsRepository.getPosts(_user);

    return allPosts
        .where((element) =>
            element.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  void onIsFavouritesProductsClicked() async {
    _isFavouritesProductsClicked = true;
    _isFavouritesSearchesClicked = false;
    _isFavouritesProfilesClicked = false;

    notifyListeners();
  }

  void onIsFavouritesSearchesClicked() async {
    _isFavouritesProductsClicked = false;
    _isFavouritesSearchesClicked = true;
    _isFavouritesProfilesClicked = false;

    notifyListeners();
  }

  void onIsFavouritesProfilesClicked() async {
    _isFavouritesProductsClicked = false;
    _isFavouritesSearchesClicked = false;
    _isFavouritesProfilesClicked = true;

    notifyListeners();
  }
}
