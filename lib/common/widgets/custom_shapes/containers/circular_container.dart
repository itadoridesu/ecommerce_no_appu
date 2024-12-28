import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final Color backgroundColor;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color borderColor;
  final bool showBorder;


  const CircularContainer({
    this.child,
    this.backgroundColor = Colors.white,
    super.key, 
    this.radius = 400, 
    this.padding, 
    this.margin, 
    this.height, 
    this.width,
    this.borderColor = TColors.borderPrimary,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}