import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_no_shoppu/data/services/firebase_storage_services.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_model.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/format_exception.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all banners related to the current user
  Future<List<BannerModel>> fetchBanners() async {
    try {

      final result = await _db.collection('Banners').where('Active', isEqualTo: true).get();
      final list =  result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
      return list;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }

  /// Upload Banners to the Cloud Firebase
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      // Upload all the Banners along with their Images
      final storage = Get.put(AFirebaseStorageService());

      // Loop through each banner
      for (var banner in banners) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData('Banners', file, 'banner ${banner.id}');

        // Assign URL to Banner's image attribute
        banner.imageUrl = url;

        // Store Baanner in Firestore
        await _db.collection("Banners").doc(banner.id).set(banner.toJson());
      }
       
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
