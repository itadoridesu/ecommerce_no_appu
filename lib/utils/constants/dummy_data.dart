import 'package:ecommerce_no_shoppu/features/shop/models/brand_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/category_model.dart';
import 'package:ecommerce_no_shoppu/routes/routes.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';

class ADummyData {

  /// Banners
  static final List<BannerModel> banners = [
    BannerModel(id: '1', imageUrl: TImages.banner1, targetScreen: TRoutes.order, active: false),
    BannerModel(id: '2', imageUrl: TImages.banner2, targetScreen: TRoutes.cart, active: true),
    BannerModel(id: '3', imageUrl: TImages.banner3, targetScreen: TRoutes.favourites, active: true),
    BannerModel(id: '4', imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
    BannerModel(id: '5', imageUrl: TImages.banner5, targetScreen: TRoutes.settings, active: true),
    BannerModel(id: '6', imageUrl: TImages.banner6, targetScreen: TRoutes.userAddress, active: true),
    BannerModel(id: '7', imageUrl: TImages.banner8, targetScreen: TRoutes.checkout, active: false),
  ];


  /// User
  // static final UserModel user = UserModel();

  /// Cart
  // static final CartModel cart = CartModel();

  /// Orders
  // static final List<OrderModel> orders = [];




  /// List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', image: TImages.sportIcon, name: 'Sports', isFeatured: true),
    CategoryModel(id: '5', image: TImages.furnitureIcon, name: 'Furniture', isFeatured: true),
    CategoryModel(id: '2', image: TImages.electronicsIcon, name: 'Electronics', isFeatured: true),
    CategoryModel(id: '3', image: TImages.clothIcon, name: 'Clothes', isFeatured: true),
    CategoryModel(id: '4', image: TImages.animalIcon, name: 'Animals', isFeatured: true),
    CategoryModel(id: '6', image: TImages.shoeIcon, name: 'Shoes', isFeatured: true),
    CategoryModel(id: '7', image: TImages.cosmeticsIcon, name: 'Cosmetics', isFeatured: true),
    CategoryModel(id: '14', image: TImages.jeweleryIcon, name: 'Jewelery', isFeatured: true),
  
    /// Subcategories for Sports
    CategoryModel(id: '8', image: TImages.sportIcon, name: 'Sport Shoes', parentId: '1', isFeatured: false),
    CategoryModel(id: '9', image: TImages.sportIcon, name: 'Track Suits', parentId: '1', isFeatured: false),
    CategoryModel(id: '10', image: TImages.sportIcon, name: 'Sports Equipments', parentId: '1', isFeatured: false),
  
    /// Subcategories for Furniture
    CategoryModel(id: '11', image: TImages.furnitureIcon, name: 'Bedroom Furniture', parentId: '5', isFeatured: false),
    CategoryModel(id: '12', image: TImages.furnitureIcon, name: 'Kitchen Furniture', parentId: '5', isFeatured: false),
    CategoryModel(id: '13', image: TImages.furnitureIcon, name: 'Office Furniture', parentId: '5', isFeatured: false),
  
    /// Subcategories for Electronics
    CategoryModel(id: '14', image: TImages.electronicsIcon, name: 'Laptop', parentId: '2', isFeatured: false),
    CategoryModel(id: '15', image: TImages.electronicsIcon, name: 'Mobile', parentId: '2', isFeatured: false),
  ];

}