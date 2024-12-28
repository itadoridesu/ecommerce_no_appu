import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  /// Constructor for TAnimationLoaderWidget.
  ///
  /// Parameters:
  /// - [text]: The text to be displayed below the animation.
  /// - [animation]: The path to the Lottie animation file.
  /// - [showAction]: Whether to show an action button below the text (default: false).
  /// - [actionText]: The text to be displayed on the action button (optional).
  /// - [onActionPressed]: Callback function when the action button is pressed (optional).
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  /// The text to be displayed below the animation.
  final String text;

  /// The path to the Lottie animation file.
  final String animation;

  /// Whether to show an action button below the text.
  final bool showAction;

  /// The text to be displayed on the action button (optional).
  final String? actionText;

  /// Callback function when the action button is pressed (optional).
  final VoidCallback? onActionPressed;

  @override
Widget build(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display Lottie animation
        Lottie.asset(
          animation,
          width: MediaQuery.of(context).size.width * 0.8, // Adjust width
        ),
        const SizedBox(height: TSizes.defaultSpace), // Add vertical spacing

        // Display text
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: TSizes.defaultSpace), // Add vertical spacing

        // Display action button if showAction is true
        if (showAction)
          SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: TColors.dark,
              ),
              child: Text(
                actionText!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: TColors.light),
              ),
            ),
          ),
      ],
    ),
  );
}
}