import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  final String name;
  final String image;
  final int price;
  final String brand;
  List<dynamic> sizes;

  ProductData({
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
    required this.sizes,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      name: json['name'],
      image: json['image'],
      price: int.parse(json['price'].toString()),
      brand: json['brand'],
      sizes: List<dynamic>.from(json['size'].map((x) => x)).cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'brand': brand,
      'size': List<dynamic>.from(sizes.map((x) => x.toJson())),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
