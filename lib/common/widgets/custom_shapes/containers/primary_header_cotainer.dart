import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class primaryHeaderContainer extends StatelessWidget {
  const primaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.primary,
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -250,
            child: CircularContainer(
              backgroundColor: TColors.textWhite.withOpacity(0.1),
              height: 400,
              width: 400,
            ),
          ),
          Positioned(
            top: 100,
            right: - 300,
            child: CircularContainer(
              backgroundColor: Colors.white.withOpacity(0.1),
              height: 400,
              width: 400,
            ),
          ),
          
          child
        ],
      ), // SizedBox
    );
  }
}