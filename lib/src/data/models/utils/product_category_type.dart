import 'package:flutter/material.dart';

class ProductCategoryType {
  static const String cars = "Coches";
  static const String computing = "Informática";
  static const String homeAppliances = "Electrodomésticos";

  static const IconData carsIcon = Icons.car_crash;
  static const IconData computingIcon = Icons.computer_rounded;
  static const IconData homeAppliancesIcon = Icons.home;

  final String value;
  final IconData icon;

  ProductCategoryType({required this.value, required this.icon});
}