import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../helpers/get.dart';

class HomeController extends ChangeNotifier implements TickerProvider {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool _userToken = false;
  bool get userToken => _userToken;

  String? _nickname;
  String? get nickname => _nickname;

  final AuthenticationRepository _repository =
      Get.i.find<AuthenticationRepository>()!;

  void Function()? onDispose;

  late TabController tabController;

  HomeController() {
    _init();
  }

  // This function is an asynchronous method that waits for a token check from the _repository, and assigns the returned value to _userToken.
  // It also retrieves the nickname of the currently logged in user using the Get library, and assigns it to the _nickname variable.
  // Finally, it calls notifyListeners() to inform listeners that the state of the object has changed.
  void laterLayout() async {
    _userToken = await _repository.tokenExists();
    _nickname = Get.i.find<User>()?.nickname;
    notifyListeners();
  }

  // This function is executed after the first layout of the widget. It calls another function called laterLayout,
  // and then sets up a listener on a TabController object.
  // When the TabController's index changes, the function updates the current page (_currentPage) and notifies any listeners that a change has occurred.
  void afterFistLayout() async {
    laterLayout();

    tabController.addListener(() {
      _currentPage = tabController.index;
      notifyListeners();
    });
  }

  void _init() async {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    if (onDispose != null) {
      onDispose!();
    }
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
