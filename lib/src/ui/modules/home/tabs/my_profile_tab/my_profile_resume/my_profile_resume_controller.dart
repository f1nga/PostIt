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

  late User _userReview;
  User get userReview => _userReview;

  late Post _postReview;
  Post get postReview => _postReview;

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
    if (_user.email == "") {
      _user = await _usersRepository.getCurrentUser();
      _comingFromMyProfile = true;
    }
    _userPosts = await _usersRepository.getPostsByUser(_user);

    _userReviews = await _reviewsRepository.getReviewsByUser(_user);

    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
  }

  void onisContainerSelected(int value) {
    _selectedContainer = value;

    notifyListeners();
  }

  void getUserAndPostByReviewId(String reviewId, String reviewPostId) async {
    _userReview = await _usersRepository.getUserByReviewId(reviewId);
    _postReview = await _postsRepository.getPostByReviewId(reviewPostId);

    _isLoading = false;
    notifyListeners();
  }
}
