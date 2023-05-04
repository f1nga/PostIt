import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/data/models/utils/product_category_type.dart';
import 'package:wallapop/src/data/models/utils/product_state_type.dart';
import 'package:wallapop/src/data/repositories/post_repository.dart';
import 'package:wallapop/src/data/repositories/user_repository.dart';

import '../../../../../data/models/user.dart';
import '../../../../../data/repositories/authentication_repository.dart';
import '../../../../../helpers/get.dart';
import '../../../../../utils/colors.dart';
import '../../../../global_widgets/custom_form.dart';

class PostitController extends ChangeNotifier {
  String _title = '', _description = '', _state = '';
  ProductCategoryType? _category;
  double _price = 0.0;
  File? _imageFile;

  final PostRepository _repository = Get.i.find<PostRepository>()!;
  final UserRepository _usersRepository = Get.i.find<UserRepository>()!;

  int _isClickedCategory = 1;
  int get isClickedCategory {
    return _isClickedCategory;
  }

  int _isClickedState = 1;
  int get isClickedState {
    return _isClickedState;
  }

  String get state {
    return _state;
  }

  ProductCategoryType? get category {
    return _category;
  }

  GlobalKey<CustomFormState> formKey = GlobalKey();

  // void onEmailChanged(String text): Sets the email value.
  void onTitleChanged(String text) {
    _title = text;
  }

  // void onPasswordChanged(String text): Sets the password value.
  void onDescriptionChanged(String text) {
    _description = text;
  }

  void onPriceChanged(String text) {
    _price = double.parse(text);
  }

  void onIsCarCategoryClicked(int value) async {
    _isClickedCategory = value;
    _category = ProductCategoryType(
      value: ProductCategoryType.cars,
      icon: ProductCategoryType.carsIcon,
    );

    notifyListeners();
  }

  void onIsComputingCategoryClicked(int value) async {
    _isClickedCategory = value;
    _category = ProductCategoryType(
      value: ProductCategoryType.computing,
      icon: ProductCategoryType.computingIcon,
    );

    notifyListeners();
  }

  void onIsHomeAppliancesCategoryClicked(int value) async {
    _isClickedCategory = value;
    _category = ProductCategoryType(
        value: ProductCategoryType.homeAppliances,
        icon: ProductCategoryType.homeAppliancesIcon);

    notifyListeners();
  }

  void onIsPerfectStateClicked(int value) async {
    _isClickedState = value;
    _state = ProductStateType.perfect;

    notifyListeners();
  }

  void onIsLikeNewStateClicked(int value) async {
    _isClickedState = value;
    _state = ProductStateType.like_new;

    notifyListeners();
  }

  void onIsGoodStateClicked(int value) async {
    _isClickedState = value;
    _state = ProductStateType.good;

    notifyListeners();
  }

  void onIsAcceptableStateClicked(int value) async {
    _isClickedState = value;
    _state = ProductStateType.acceptable;

    notifyListeners();
  }

  void onIsBustedStateClicked(int value) async {
    _isClickedState = value;
    _state = ProductStateType.busted;

    notifyListeners();
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

  Widget getIconState() {
    if (_imageFile == null) {
      return const Icon(
        Icons.image_search,
        color: secondaryColor,
        size: 32,
      );
    } else {
      return Image.file(
        _imageFile!,
        fit: BoxFit.fill,
      );
    }
  }

  Future<bool> submit() async {
    return _repository.addPost(
      Post(
        title: _title,
        description: _description,
        price: _price,
        category: _category!.value,
        state: _state,
        file: _imageFile!,
      ),
      await _usersRepository.getCurrentUser(),
    );
  }
}
