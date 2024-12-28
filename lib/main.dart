import 'package:ecommerce_no_shoppu/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_no_shoppu/firebase_options.dart';
import 'package:ecommerce_no_shoppu/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {

  // Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //Init Local Storage
  await GetStorage.init();

  // Todo: Init Payment Methods


  // Await Native splash till other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  
  // Todo: Init Firebase & auth repository 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository())
    );

  // Todo: Init Authentication


  runApp(const MyApp());
}

