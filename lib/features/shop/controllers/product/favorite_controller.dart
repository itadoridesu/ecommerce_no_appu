import 'dart:convert';
import 'package:ecommerce_no_shoppu/data/repositories/product/product_repository.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/utils/local_storage/storage_utility.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();


  final favorites = <String, bool>{}.obs;


  @override
  void onInit() {
    super.onInit();
    initFavorite();
  }
  
  void initFavorite() {

    final json = TLocalStorage.instance().readData('favorites');
    if(json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool),));
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }


  void toggleFavoriteProduct(String productId) {
    if(!favorites.containsKey(productId)){
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Product has been added to the Wishlist desu!');
    } else {
      TLocalStorage.instance().readData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Product has been removed from the Wishlist desu!');

    }
  }
  
  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveData('favorites', encodedFavorites);

  }

  Future<List<ProductModel>> getfavoriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
  }

}