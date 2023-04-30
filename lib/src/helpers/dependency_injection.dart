import 'package:wallapop/src/data/providers/post_provider.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';

import '../data/providers/authentication_provider.dart';
import '../data/repositories_implementation/post_repository_impl.dart';
import 'get.dart';

import '../data/repositories/authentication_repository.dart';
import '../data/repositories_implementation/authentication_repository_impl.dart';

abstract class DependencyInjection {
  static void initialize() {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepositoryImpl(AuthenticationProvider());
    final PostRepository postRepository = PostRepositoryImpl(PostProvider());

    Get.i.put<AuthenticationRepository>(authenticationRepository);
    Get.i.put<PostRepository>(postRepository);
  }
}
