import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_no_shoppu/data/services/firebase_storage_services.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Firebase Firestore instance
  final _db = FirebaseFirestore.instance;

  /// Get all products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // Fetch all products (documents that are in the categories collection) from Firestore
      final allDocuments = await _db.collection('Products').limit(4).get(); // You can add conditions 'where()' or limit the number 'limit(4)'

      // Map each document snapshot to a ProductModel
      final list = allDocuments.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
      return list;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      // Fetch all products (documents that are in the categories collection) from Firestore
      final allDocuments = await _db.collection('Products').get(); // You can add conditions 'where()' or limit the number 'limit(4)'

      // Map each document snapshot to a ProductModel
      final list = allDocuments.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
      return list;
      
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Products based on the Brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      // Execute the query and fetch the snapshot
      final querySnapshot = await query.get();  

      // Map the snapshot documents to a list of ProductModel
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();  

      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // Catch any other exceptions and rethrow
  }

  throw 'Something went wrong. Please try again';
}


  /// Get Sub Products
  /// Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Upload all the products along with their images
      final storage = Get.put(AFirebaseStorageService());

      // Loop through each product
      for (var product in products) {
        // Get image data link from local assets
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);

        // Upload image and get its URL
        final url = await storage.uploadImageData('Products/Images', thumbnail, sanitizeFileName(product.thumbnail.toString()));

        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images', assetImage, sanitizeFileName(image));

            // Assign URL to imagesUrl
            imagesUrl.add(url);
          }

          // Clear existing images and add URLs
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // Upload Variation Images
        if (product.productType == 'ProductType.variable') {
          for (var variation in product.productVariations!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images', assetImage, sanitizeFileName(variation.image));

            // Assign URL to variation.image attribute
            variation.image = url;
          }
        }

        // Store product in Firestore
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  String sanitizeFileName(String name) {
  // Remove any unwanted characters (like slashes, spaces, etc.)
  return name.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
}

}
