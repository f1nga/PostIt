import 'package:flutter/material.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../../../data/models/user.dart';
import '../../../../../../../helpers/get.dart';

class MyPostDetailController extends ChangeNotifier {
  final PostRepository _postsRepository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  Future<bool> deletePost(String postId) async {
    return await _postsRepository.deletePost(postId) &&
        await _usersRepository.deleteUserPost(
          postId,
          await getCurrentUser(),
        );
  }

  Future<User> getCurrentUser() async {
    return await _usersRepository.getCurrentUser();
  }
}
