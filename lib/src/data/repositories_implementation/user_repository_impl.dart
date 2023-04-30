import 'package:wallapop/src/data/models/user.dart';

import 'package:wallapop/src/data/models/post.dart';

import '../providers/user_provider.dart';
import '../repositories/user_repository.dart';

/// Class that implements the provider obligatory methods
class UserRepositoryImpl implements UserRepository {
  final UserProvider _userProvider;

  UserRepositoryImpl(this._userProvider);

  @override
  Future<List<Post>> getPostsByUser(User user) {
    return _userProvider.getPostsByUser(user);
  }
}
