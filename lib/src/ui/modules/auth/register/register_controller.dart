import 'package:flutter/widgets.dart';
import '../../../../helpers/get.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../global_widgets/custom_form.dart';

/// Controller class for the register form
class RegisterController extends ChangeNotifier {
  String _nickname = '', _email = '', _password = '', _password2 = '';
  final AuthenticationRepository _repository =
      Get.i.find<AuthenticationRepository>()!;

  GlobalKey<CustomFormState> formKey = GlobalKey();

  // void onNicknameChanged(String text): Sets the nickname value.
  void onNicknameChanged(String text) {
    _nickname = text;
  }

  // void onEmailChanged(String text): Sets the email value.
  void onEmailChanged(String text) {
    _email = text;
  }

  // void onPasswordChanged(String text): Sets the password value.
  void onPasswordChanged(String text) {
    _password = text;
  }

  // void onPasswordChanged2(String text): Sets the second password value.
  void onPasswordChanged2(String text) {
    _password2 = text;
  }

  // bool validatePasswordsMatch(): Checks if the two password fields are the same and returns true if they match.
  bool validatePasswordsMatch() {
    return _password == _password2;
  }

  /// Function that calls the register provider function
  /// @returns {boolean} Returns true if everything go ok, return false if the user already exist.
  Future<bool> submit() async {
    return _repository.register(
      _nickname,
      _email,
      _password,
    );
  }
}
