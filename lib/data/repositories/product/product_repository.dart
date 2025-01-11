import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_no_shoppu/data/services/firebase_storage_services.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product_category_model.dart';
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
      final allDocuments = await _db
          .collection('Products')
          .limit(4)
          .get(); // You can add conditions 'where()' or limit the number 'limit(4)'

      // Map each document snapshot to a ProductModel
      final list = allDocuments.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
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
      final allDocuments = await _db
          .collection('Products')
          .get(); // You can add conditions 'where()' or limit the number 'limit(4)'

      // Map each document snapshot to a ProductModel
      final list = allDocuments.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
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
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

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

  /// Get Products of the same brand
  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;

      // You can process `querySnapshot` here if needed
      // Example: return querySnapshot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Products for a Category.
  Future<List<ProductModel>> getProductsForCategory({required String categoryId,int limit = 4,}) async {
    try {
      // Query to get all documents where categoryId matches the provided categoryId
      // Fetch limited or unlimited based on the 'limit' value
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      // Extract productIds from the documents
      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      // Query to get all documents where the productId is in the list of productIds
      final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

      // Map the query results to a list of ProductModel
      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  
  Future<void> uploadProductCategories(List<ProductCategoryModel> productCategories) async {
  try {
    for (var productCategory in productCategories) {

      await FirebaseFirestore.instance.collection("ProductCategory").add(productCategory.toJson()); 
    }
  } on FirebaseException catch (e) {
    throw Exception("Firebase Error: ${e.message}");
  } catch (e) {
    throw Exception("Something went wrong: $e");
  }
}

  /// Get Products based on the Query
Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
  try {
    final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();
    return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();
    
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
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
        final url = await storage.uploadImageData('Products/Images', thumbnail,
            sanitizeFileName(product.thumbnail.toString()));

        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, sanitizeFileName(image));

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
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images',
                assetImage, sanitizeFileName(variation.image));

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
