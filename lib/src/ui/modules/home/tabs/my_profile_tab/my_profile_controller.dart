import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../data/models/user.dart';
import '../../../../../helpers/get.dart';

class MyProfileController extends ChangeNotifier {
  String _nickname = "", _image = "";
  int _stars = 0;
  int? get stars => _stars;
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
    notifyListeners();
  }
}
