import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../helpers/get.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../global_widgets/custom_form.dart';

/// Controller class for the register form
class RegisterController extends ChangeNotifier {
  String _nickname = '', _email = '', _password = '', _password2 = '';

  File? _imageFile;
  File? get imageFile => _imageFile;

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

  void getFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (image != null) {
      _imageFile = File(image.path);
      notifyListeners();
    }
  }

  /// Function that calls the register provider function
  /// @returns {boolean} Returns true if everything go ok, return false if the user already exist.
  Future<bool> submit() async {
    return _repository.register(
      _nickname,
      _email,
      _password,
      _imageFile,
    );
  }
}
