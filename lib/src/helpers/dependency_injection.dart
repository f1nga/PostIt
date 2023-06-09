import 'package:wallapop/src/data/providers/post_provider.dart';
import 'package:wallapop/src/data/providers/review_provider.dart';
import 'package:wallapop/src/data/providers/user_provider.dart';
import 'package:wallapop/src/data/repositories/chat_repository.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/review_repository.dart';
import 'package:wallapop/src/data/repositories_implementation/review_repository_impl.dart';

import '../data/providers/authentication_provider.dart';
import '../data/providers/chat_provider.dart';
import '../data/repositories/user_repository.dart';
import '../data/repositories_implementation/chat_repository_impl.dart';
import '../data/repositories_implementation/post_repository_impl.dart';
import '../data/repositories_implementation/user_repository_impl.dart';
import 'get.dart';

import '../data/repositories/authentication_repository.dart';
import '../data/repositories_implementation/authentication_repository_impl.dart';

abstract class DependencyInjection {
  static void initialize() {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepositoryImpl(AuthenticationProvider());
    final PostRepository postRepository = PostRepositoryImpl(PostProvider());
    final UserRepository userRepository = UserRepositoryImpl(UserProvider());
    final ReviewRepository reviewRepository =
        ReviewRepositoryImpl(ReviewProvider());
    final ChatRepository messageRepository = ChatRepositoryImpl(ChatProvider());

    Get.i.put<AuthenticationRepository>(authenticationRepository);
    Get.i.put<PostRepository>(postRepository);
    Get.i.put<UserRepository>(userRepository);
    Get.i.put<ReviewRepository>(reviewRepository);
    Get.i.put<ChatRepository>(messageRepository);
  }
}
