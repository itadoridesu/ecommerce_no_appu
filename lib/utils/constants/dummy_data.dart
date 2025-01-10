import 'package:ecommerce_no_shoppu/features/shop/models/banner_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_category_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/category_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_attributes_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_variation_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product_category_model.dart';
import 'package:ecommerce_no_shoppu/routes/routes.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';

class ADummyData {
  /// Banners
  static final List<BannerModel> banners = [
    BannerModel(
        id: '1',
        imageUrl: TImages.banner1,
        targetScreen: TRoutes.order,
        active: false),
    BannerModel(
        id: '2',
        imageUrl: TImages.banner2,
        targetScreen: TRoutes.cart,
        active: true),
    BannerModel(
        id: '3',
        imageUrl: TImages.banner3,
        targetScreen: TRoutes.favourites,
        active: true),
    BannerModel(
        id: '4',
        imageUrl: TImages.banner4,
        targetScreen: TRoutes.search,
        active: true),
    BannerModel(
        id: '5',
        imageUrl: TImages.banner5,
        targetScreen: TRoutes.settings,
        active: true),
    BannerModel(
        id: '6',
        imageUrl: TImages.banner6,
        targetScreen: TRoutes.userAddress,
        active: true),
    BannerModel(
        id: '7',
        imageUrl: TImages.banner8,
        targetScreen: TRoutes.checkout,
        active: false),
  ];

  /// User
  // static final UserModel user = UserModel();

  /// Cart
  // static final CartModel cart = CartModel();

  /// Orders
  // static final List<OrderModel> orders = [];

  /// List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: TImages.sportIcon, name: 'Sports', isFeatured: true),
    CategoryModel(
        id: '5',
        image: TImages.furnitureIcon,
        name: 'Furniture',
        isFeatured: true),
    CategoryModel(
        id: '2',
        image: TImages.electronicsIcon,
        name: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '3', image: TImages.clothIcon, name: 'Clothes', isFeatured: true),
    CategoryModel(
        id: '4', image: TImages.animalIcon, name: 'Animals', isFeatured: true),
    CategoryModel(
        id: '6', image: TImages.shoeIcon, name: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '7',
        image: TImages.cosmeticsIcon,
        name: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '14',
        image: TImages.jeweleryIcon,
        name: 'Jewelery',
        isFeatured: true),

    /// Subcategories for Sports
    CategoryModel(
        id: '8',
        image: TImages.sportIcon,
        name: 'Sport Shoes',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '9',
        image: TImages.sportIcon,
        name: 'Track Suits',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '10',
        image: TImages.sportIcon,
        name: 'Sports Equipments',
        parentId: '1',
        isFeatured: false),

    /// Subcategories for Furniture
    CategoryModel(
        id: '11',
        image: TImages.furnitureIcon,
        name: 'Bedroom Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '12',
        image: TImages.furnitureIcon,
        name: 'Kitchen Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '13',
        image: TImages.furnitureIcon,
        name: 'Office Furniture',
        parentId: '5',
        isFeatured: false),

    /// Subcategories for Electronics
    CategoryModel(
        id: '14',
        image: TImages.electronicsIcon,
        name: 'Laptop',
        parentId: '2',
        isFeatured: false),
    CategoryModel(
        id: '15',
        image: TImages.electronicsIcon,
        name: 'Mobile',
        parentId: '2',
        isFeatured: false),
  ];

  // List of all Products
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 135,
      isFeatured: true,
      thumbnail: TImages.productImage1,
      description: 'Green Nike sports shoe',
      brand: BrandModel(
        id: '1',
        image: TImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        TImages.productImage1,
        TImages.productImage23,
        TImages.productImage21,
        TImages.productImage9,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '1',
      productType: "ProductType.variable",
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: TImages.productImage1,
          description:
              'This is a Product description for Green Nike sports shoe.',
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 45,
          price: 130,
          salePrice: 120,
          image: TImages.productImage23,
          description:
              'Another Product description for Green Nike sports shoe.',
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
      ],
    ),
    ProductModel(
      id: '002',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbnail: TImages.productImage69,
      description:
          'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but I am just practicing and nothing else.',
      brand: BrandModel(
        id: '6',
        image: TImages.zaraLogo,
        name: 'ZARA',
      ),
      images: [
        TImages.productImage68,
        TImages.productImage69,
        TImages.productImage5
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '003',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 38000,
      isFeatured: false,
      thumbnail: TImages.productImage64,
      description:
          'This is a Product description for Leather brown Jacket. There are more things that can be added but I am just practicing and nothing else.',
      brand: BrandModel(
        id: '6',
        image: TImages.zaraLogo,
        name: 'ZARA',
      ),
      images: [
        TImages.productImage64,
        TImages.productImage65,
        TImages.productImage66,
        TImages.productImage67,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '005',
      title: 'Nike Air Jordon Shoes',
      stock: 15,
      price: 35,
      isFeatured: false,
      thumbnail: TImages.productImage10,
      description:
          'Nike Air Jordon Shoes for running. Quality product, Long Lasting',
      brand: BrandModel(
        id: '1',
        image: TImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        TImages.productImage7,
        TImages.productImage8,
        TImages.productImage9,
        TImages.productImage10,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Orange', 'Black', 'Brown']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 16,
          price: 36,
          salePrice: 12.6,
          image: TImages.productImage8,
          description:
              'Flutter is Google\'s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
          attributeValues: {'Color': 'Orange', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 35,
          image: TImages.productImage7,
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 14,
          price: 34,
          image: TImages.productImage9,
          attributeValues: {'Color': 'Brown', 'Size': 'EU 34'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
  ];

  static final List<BrandModel> brandList = [
    BrandModel(
      id: '1',
      name: 'Nike',
      image: TImages.nikeLogo,
      isFeatured: true,
      productsCount: 120,
    ),
    BrandModel(
      id: '2',
      name: 'Adidas',
      image: TImages.adidasLogo,
      isFeatured: false,
      productsCount: 95,
    ),
    BrandModel(
      id: '3',
      name: 'Apple',
      image: TImages.appleLogo,
      isFeatured: true,
      productsCount: 75,
    ),
    BrandModel(
      id: '4',
      name: 'Jordan',
      image: TImages.jordanLogo,
      isFeatured: true,
      productsCount: 60,
    ),
    BrandModel(
      id: '5',
      name: 'Puma',
      image: TImages.pumaLogo,
      isFeatured: false,
      productsCount: 80,
    ),
    BrandModel(
      id: '6',
      name: 'Zara',
      image: TImages.zaraLogo,
      isFeatured: false,
      productsCount: 50,
    ),
    BrandModel(
      id: '7',
      name: 'Kenwood',
      image: TImages.kenwoodLogo,
      isFeatured: true,
      productsCount: 40,
    ),
    BrandModel(
      id: '8',
      name: 'Herman Miller',
      image: TImages.hermanMillerLogo,
      isFeatured: false,
      productsCount: 25,
    ),
    BrandModel(
      id: '9',
      name: 'Ikea',
      image: TImages.ikeaLogo,
      isFeatured: true,
      productsCount: 100,
    ),
    BrandModel(
      id: '10',
      name: 'Acer',
      image: TImages.acerlogo,
      isFeatured: false,
      productsCount: 30,
    ),
  ];

  static final List<BrandCategoryModel> brandCategories = [
  // Sports (Category ID: 1)
  BrandCategoryModel(brandId: '1', categoryId: '1'), // Nike
  BrandCategoryModel(brandId: '2', categoryId: '1'), // Adidas
  BrandCategoryModel(brandId: '4', categoryId: '1'), // Jordan

  // Electronics (Category ID: 2)
  BrandCategoryModel(brandId: '3', categoryId: '2'), // Apple

  // Clothes (Category ID: 3)
  BrandCategoryModel(brandId: '6', categoryId: '3'), // Zara
];


  static final List<ProductCategoryModel> productCategories = [
    ProductCategoryModel(productId: '001', categoryId: '1'),
    ProductCategoryModel(productId: '002', categoryId: '3'), 
    ProductCategoryModel(productId: '003', categoryId: '3'), 
    ProductCategoryModel(productId: '004', categoryId: '2'), 
    ProductCategoryModel(productId: '005', categoryId: '8'), 
    ProductCategoryModel(productId: '006', categoryId: '3'), 
    ProductCategoryModel(productId: '007', categoryId: '6'), 
];

}
