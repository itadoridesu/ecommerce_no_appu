import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String id;
  String imageUrl;
  final String targetScreen;
  final bool active;

  // Constructor
  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  // Convert BannerModel to a JSON map (for saving to Firebase or other storage)
  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }

  /// Empty Helper Function
  static BannerModel empty() => BannerModel(id: '', imageUrl: '', targetScreen: '', active: false);


  // Convert Firestore document snapshot to BannerModel
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      imageUrl: data['ImageUrl'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
    );
  }
}
