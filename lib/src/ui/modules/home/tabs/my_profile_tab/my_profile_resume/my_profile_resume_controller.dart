import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../data/models/post.dart';
import '../../../../../../data/models/user.dart';
import '../../../../../../data/repositories/user_repository.dart';
import '../../../../../../helpers/get.dart';

class MyProfileResumeController extends ChangeNotifier {
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  String _nickname = "", _image = "";
  int _stars = 0, _sales = 0, _purchases = 0;
  List<Post> _userPosts = [];
  List<Post> get userPosts => _userPosts;
  int? get stars => _stars;
  int? get sales => _sales;
  int? get purchases => _purchases;
  String? get nickname => _nickname;
  String? get image => _image;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _nickname = Get.i.find<User>()!.nickname;
    _image = Get.i.find<User>()!.image;
    _stars = Get.i.find<User>()!.stars;
    _sales = Get.i.find<User>()!.sales;
    _purchases = Get.i.find<User>()!.purchases;
    _userPosts = await _usersRepository.getPostsByUser(Get.i.find<User>()!);
    notifyListeners();
  }
}
