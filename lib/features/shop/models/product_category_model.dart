import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  String productId;
  String categoryId;

  ProductCategoryModel({required this.productId, required this.categoryId});

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
    };
  }

  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) { 
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(
      productId: data['productId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
