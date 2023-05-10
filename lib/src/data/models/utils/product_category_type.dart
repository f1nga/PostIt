import 'package:flutter/material.dart';

class ProductCategoryType {
  static const String cars = "Coches";
  static const String pcs = "Ordenadores";
  static const String homeAppliances = "Electrodomésticos";
  static const String mobiles = "Móviles";
  static const String consoles = "Consolas";
  static const String motorcycles = "Motos";
  static const String sports = "Deportes";
  static const String realEstate = "Inmobiliaria";

  static const IconData carsIcon = Icons.car_crash;
  static const IconData pcsIcon = Icons.computer_rounded;
  static const IconData homeAppliancesIcon = Icons.home;
  static const IconData mobilesIcon = Icons.mobile_friendly;
  static const IconData consolesIcon = Icons.gamepad;
  static const IconData motorcyclesIcon = Icons.motorcycle;
  static const IconData sportsIcon = Icons.sports;
  static const IconData realEstateIcon = Icons.construction;

  final String value;
  final IconData icon;

  ProductCategoryType({required this.value, required this.icon});
}
