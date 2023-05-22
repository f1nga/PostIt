import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallapop/src/data/models/review.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/review_repository.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../data/models/user.dart';
import '../../../../../../data/repositories/user_repository.dart';
import '../../../../../../helpers/get.dart';

class MyProfileResumeController extends ChangeNotifier {
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;
  final ReviewRepository _reviewsRepository = Get.i.find<ReviewRepository>()!;
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;

  User _user = User(nickname: "", email: "");
  User get user => _user;

  List<Post> _userPosts = [];
  List<Post> get userPosts => _userPosts;

  List<Review> _userReviews = [];
  List<Review> get userReviews => _userReviews;

  final List<User> _userPost = [];
  List<User> get userPost => _userPost;

  final List<User> _userReview = [];
  List<User> get userReview => _userReview;

  final List<Post> _postReview = [];
  List<Post> get postReview => _postReview;

  int _selectedContainer = 1;
  int get selectedContainer => _selectedContainer;

  bool _comingFromMyProfile = false;
  bool get comingFromMyProfile => _comingFromMyProfile;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    final user = await _usersRepository.getCurrentUser();
    if (_user.email == "" || _user.email == user.email) {
      _user = await _usersRepository.getCurrentUser();
      _comingFromMyProfile = true;
    }
    _userPosts = await _usersRepository.getPostsByUser(_user);

    _userReviews = await _reviewsRepository.getReviewsByUser(_user);

    for (Review review in _userReviews) {
      _userReview.add(await _usersRepository.getUserByReviewId(review.id));
      final Post post = await _postsRepository.getPostByReviewId(review.postId);
      _postReview.add(post);
      _userPost.add(await _usersRepository.getUserByPostId(post.id));
    }

    _isLoading = false;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void onisContainerSelected(int value) {
    _selectedContainer = value;

    notifyListeners();
  }
}
