import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_no_shoppu/data/services/firebase_storage_services.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_category_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_model.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/format_exception.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get All Brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (__) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Brands.';
    }
  }


/// Get Brands For Category
Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
  try {
    // Query to get all documents where categoryId matches the provided categoryId
    QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategories').where('categoryId', isEqualTo: categoryId).get();

    // Extract brandIds from the documents
    List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

    // Query to get all documents where the brandId is in the list of brandIds
    final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

    final list = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

    return list;

  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (__) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong while fetching Brands.';
  }
}




  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(AFirebaseStorageService());

      // Loop through each category
      for (var brand in brands) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(brand.image);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData('Brands', file, brand.name);

        // Assign URL to Category's image attribute
        brand.image = url;

        // Store Category in Firestore
        await _db.collection("Brands").doc(brand.id).set(brand.toJson());
      }
       
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadBrandCategories(List<BrandCategoryModel> brandCategories) async {
  try {
    for (var brandCategory in brandCategories) {

      await FirebaseFirestore.instance.collection("BrandCategories").add(brandCategory.toJson()); 
    }
  } on FirebaseException catch (e) {
    throw Exception("Firebase Error: ${e.message}");
  } catch (e) {
    throw Exception("Something went wrong: $e");
  }
}

}
