import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../data/models/user.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../../../helpers/get.dart';

class MyProfileController extends ChangeNotifier {
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  String _nickname = "", _image = "";
  int _stars = 0;
  int? get stars => _stars;
  String? get nickname => _nickname;
  String? get image => _image;

  bool isLoading = true;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    final User user = await _usersRepository.getCurrentUser();
    _nickname = user.nickname;
    _image = user.image;
    _stars = user.stars;
    isLoading = false;
    notifyListeners();
  }
}
