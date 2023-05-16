import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallapop/src/data/models/post.dart';
import 'package:wallapop/src/utils/methods.dart';

class HomeTabCategoryModel {
  late IconData icon;
  late String title;

  HomeTabCategoryModel({
    required this.icon,
    required this.title,
  });
}
