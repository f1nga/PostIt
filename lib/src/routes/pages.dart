import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/auth/login/login_page.dart';
import 'package:wallapop/src/ui/modules/auth/register/register_page.dart';
import 'package:wallapop/src/ui/modules/home/home_page.dart';
import 'package:wallapop/src/ui/modules/home/pages/post_detail/post_detail_page.dart';
import 'package:wallapop/src/ui/modules/home/tabs/my_profile_tab/my_profile_resume/my_profile_resume_page.dart';

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
    Routes.profileResume: (_) => const MyProfileResumePage(),
    Routes.postDetail: (_) => const PostDetailPage(),
  };
}
