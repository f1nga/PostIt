import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/auth/login/login_page.dart';
import 'package:wallapop/src/ui/modules/auth/register/register_page.dart';
import 'package:wallapop/src/ui/modules/home/home_page.dart';

import '../ui/modules/splash/splash_page.dart';
import '../ui/modules/welcome/welcome_page.dart';
import 'routes.dart';

abstract class Pages {
  static const String initial = Routes.splash;

  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.splash: (_) => const SplashPage(),
    Routes.welcome: (_) => const WelcomePage(),
    Routes.register: (_) => const RegisterPage(),
    Routes.login: (_) => const LoginPage(),
    Routes.home: (_) => const HomePage(),
  };
}
