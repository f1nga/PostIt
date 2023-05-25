import 'package:flutter/material.dart';
import 'package:wallapop/src/data/repositories/review_repository.dart';

import '../../../../../data/models/review.dart';
import '../../../../../data/models/user.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../../../helpers/get.dart';

class PurchaseReviewController extends ChangeNotifier {
  final ReviewRepository _reviewsRepository = Get.i.find<ReviewRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  int _clickedStars = 0;
  int get clickedStars => _clickedStars;

  String _descriptionReview = "";
  String get descriptionReview => _descriptionReview;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    notifyListeners();
  }

  void onReviewDescriptionChanged(String descriptionReview) {
    _descriptionReview = descriptionReview;
  }

  void onIsStarsClicked(int starsValue) {
    _clickedStars = starsValue;

    notifyListeners();
  }

  Future<bool> onIsSendReviewButtonClicked(Review review) async {
    return _reviewsRepository.addReview(
        review, await _usersRepository.getCurrentUser());
  }

  Future<bool> updateUserStarsFromDB(User user) async {
    final List<Review> reviews =
        await _reviewsRepository.getReviewsByUser(user);

    return await _usersRepository.updateUserStars(reviews, user);
  }
}
