import 'package:ecommerce_no_shoppu/features/authentication/screens/login/forgot_password.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/login/login.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/on_boarding/on_boarding.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/sign_up/sign_up.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/sign_up/verify_email.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/address/address.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/order/orders.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/profile/profile.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/settings/settings.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/cart/cart.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/home/home.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/store/store.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/wishlist/wishlist.dart';
import 'package:ecommerce_no_shoppu/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: TRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAdressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
    // Add more GetPage entries as needed
  ];
}
