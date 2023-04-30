import 'package:flutter/widgets.dart';

import '../../../../data/models/user.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../helpers/get.dart';
import '../../../global_widgets/custom_form.dart';

class LoginController extends ChangeNotifier {
  String _email = '', _password = '';
  final AuthenticationRepository _repository =
      Get.i.find<AuthenticationRepository>()!;

  GlobalKey<CustomFormState> formKey = GlobalKey();

  // void onEmailChanged(String text): Sets the email value.
  void onEmailChanged(String text) {
    _email = text;
  }

  // void onPasswordChanged(String text): Sets the password value.
  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<User?> authenticate() async {
    return _repository.login(
      _email,
      _password,
    );
  }
}
