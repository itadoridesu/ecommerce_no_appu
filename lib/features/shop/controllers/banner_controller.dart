import 'package:ecommerce_no_shoppu/data/repositories/banners/banners_repository.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_model.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final isLoading = false.obs;
  Rx<int> carousalCurentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  void updateImageIndicator (index) {
    carousalCurentIndex.value = index;
    }

   @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

    /// -- Load banners data
  Future<void> fetchBanners() async {
    try {

      // Show Loader while loading categories
      isLoading.value = true;

      // Fetch banners from data source (Firestore, API, etc.)
      final bannerRepo = Get.put(BannerRepository());
      final bannersList = await bannerRepo.fetchBanners();

      // Update the banners list (handled by GetX automatically)
      banners.assignAll(bannersList);


      // Filter  banners

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    } finally {
      isLoading.value = false;
    }
  }
}