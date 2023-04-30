import "../models/user.dart";

/// Abstract class that contains the necessary methods for the provider
abstract class AuthenticationRepository {
  Future<bool> register(String nickname, String email, String password);
  Future<User?> login(String email, String password);
  Future<bool> tokenExists();
  Future<void> myUser();
}
