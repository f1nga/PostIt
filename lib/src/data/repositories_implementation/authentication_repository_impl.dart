import 'dart:io';

import '../models/user.dart';
import '../providers/authentication_provider.dart';
import '../repositories/authentication_repository.dart';

/// Class that implements the provider obligatory methods
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider;

  AuthenticationRepositoryImpl(this._authenticationProvider);

  @override
  Future<bool> register(String nickname, String email, String password, File? image) {
    return _authenticationProvider.register(nickname, email, password, image);
  }

  @override
  Future<User?> login(String email, String password) {
    return _authenticationProvider.login(email, password);
  }

   @override
  Future<bool> tokenExists() {
    return _authenticationProvider.tokenExists();
  }

  @override
  Future<void> myUser() {
    return _authenticationProvider.myUser();
  }
}
