import 'package:ecommerce_no_shoppu/data/repositories/categories/category_repository.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/category_model.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Moved fetchCategories() inside onInit()
  }

  /// -- Load category data
  Future<void> fetchCategories() async {
    try {

      // Show Loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories list (handled by GetX automatically)
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    } finally {
      isLoading.value = false;
    }
  }
}

