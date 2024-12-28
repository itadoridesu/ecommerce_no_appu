import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  ); // BoxShadow

  static final horizontalProductShadow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.8),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  ); // BoxShadow
}
