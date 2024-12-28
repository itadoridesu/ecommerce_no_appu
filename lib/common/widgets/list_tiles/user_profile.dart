import 'package:ecommerce_no_shoppu/common/widgets/images/circular_image.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ClipOval(
        child: CircularImage(
          image: TImages.user,
          height: 50,
          width: 50,
          padding: 0,
        ),      
      ),
      title: Text('dmdm hh', style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
      subtitle: Text('ademhamizi2005@gmail.com', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white.withOpacity(.8)),),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white,)),
    );
  }
}