import 'package:ecommerce_no_shoppu/common/widgets/navigation_menu.dart';
import 'package:ecommerce_no_shoppu/data/repositories/user/user_repisitory.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/sign_up/verify_email.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/firebase_auth_exception.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/login/login.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/on_boarding/on_boarding.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/format_exception.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/platform_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated user data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  void screenRedirect() async {
    User? user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      // Check if first time launching the app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

/* -------------------- Email & Password Sign-In -------------------- */

  /// [EmailAuthentication] - Login
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - Email Verification
  Future<void> ourSendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - Re-authenticate User
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
  try {
    // Create a credential
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

    // Re-authenticate
    await _auth.currentUser!.reauthenticateWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    // Handle Firebase authentication errors
    throw TFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
    // Handle general Firebase exceptions
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    // Handle format exceptions (e.g., invalid email/password format)
    throw const TFormatException();
  } on PlatformException catch (e) {
    // Handle platform-specific exceptions
    throw TPlatformException(e.code).message;
  } catch (e) {
    // Catch any other unexpected errors
    throw 'Something went wrong. Please try again';
  }
}


  /// [EmailAuthentication] - Forgot Password*
  Future<void> sendPasswordRestEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


/* -------------------- Federated Identity & Social Sign-In -------------------- */

  /// [GoogleAuthentication] - Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the Usercredential
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if(kDebugMode) print('Something went wrong: $e');
      return null;    
    }
  }

  /// [FacebookAuthentication] - Facebook Sign-In

/* -------------------- User Management -------------------- */

  /// [LogoutUser] - Log out the current authenticated user
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DeleteUser] - Remove user authentication and delete Firestore account
  Future<void> deleteAccount() async {
  try {
    await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);

    // Sign out from Google to clear cached credentials
    await GoogleSignIn().signOut();

    await _auth.currentUser?.delete();
  } on FirebaseAuthException catch (e) {
    throw TFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
}

}


