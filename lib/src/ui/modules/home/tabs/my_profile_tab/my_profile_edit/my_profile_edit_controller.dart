import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallapop/src/data/models/user.dart';
import 'package:wallapop/src/data/repositories/authentication_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import 'package:intl/intl.dart';

import '../../../../../../helpers/get.dart';

class MyProfileEditController extends ChangeNotifier {
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;
  final AuthenticationRepository _authRepository =
      Get.i.find<AuthenticationRepository>()!;

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool _imageLoading = false;
  bool get imageLoading => _imageLoading;

  final TextEditingController _textFieldNameController =
      TextEditingController();
  TextEditingController get textFieldNameController => _textFieldNameController;

  final TextEditingController _textFieldEmailController =
      TextEditingController();
  TextEditingController get textFieldEmailController =>
      _textFieldEmailController;

  final TextEditingController _textFieldPhoneController =
      TextEditingController();
  TextEditingController get textFieldPhoneController =>
      _textFieldPhoneController;

  final TextEditingController _textFieldDescriptionController =
      TextEditingController();
  TextEditingController get textFieldDescriptionController =>
      _textFieldDescriptionController;

  final TextEditingController _textFieldBirthDateController =
      TextEditingController();
  TextEditingController get textFieldBirthDateController =>
      _textFieldBirthDateController;

  void Function()? onDispose;

  void afterFistLayout() {
    _init();
  }

  void _init() async {
    _currentUser = await _usersRepository.getCurrentUser();

    _textFieldNameController.text = _currentUser!.nickname;
    _textFieldEmailController.text = currentUser!.email;
    _textFieldDescriptionController.text = currentUser!.description;
    _textFieldPhoneController.text =
        _currentUser!.phone != null ? _currentUser!.phone.toString() : "";
    _textFieldBirthDateController.text = _currentUser!.birthdate;

    notifyListeners();
  }

  void getFromGallery() async {
    if (_currentUser != null) {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        _imageLoading = true;
        notifyListeners();

        _currentUser!.file = File(image.path);

        _currentUser!.image = await FirebaseStorage.instance
            .ref("users_bucket")
            .child(
              _currentUser!.file.hashCode.toString(),
            )
            .putFile(
              _currentUser!.file!,
            )
            .then(
              (task) => task.ref.getDownloadURL(),
            );
        _imageLoading = false;
        notifyListeners();
      }
    }
  }

  Future<bool> submit() async {
    if (isValidEmail(_textFieldEmailController.text) &&
        isValidPhone(int.parse(_textFieldPhoneController.text)) &&
        isValidBirthDate(_textFieldBirthDateController.text)) {
      _currentUser!.nickname = _textFieldNameController.text;
      _currentUser!.email = _textFieldEmailController.text;
      _currentUser!.phone = int.parse(_textFieldPhoneController.text);
      _currentUser!.description = _textFieldDescriptionController.text;
      _currentUser!.birthdate = _textFieldBirthDateController.text;

      return await _usersRepository.updateUser(_currentUser!.id, _currentUser!);
    }
    return false;
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool isValidPhone(int phone) {
    return phone.toString().length == 9;
  }

  bool isValidBirthDate(String birthdate) {
    try {
      final dateFormat = DateFormat('dd/MM/yyyy');
      final parsedDate = dateFormat.parseStrict(birthdate);

      if (parsedDate.day != int.parse(birthdate.substring(0, 2)) ||
          parsedDate.month != int.parse(birthdate.substring(3, 5)) ||
          parsedDate.year != int.parse(birthdate.substring(6, 10))) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
