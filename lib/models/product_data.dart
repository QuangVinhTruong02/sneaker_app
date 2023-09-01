import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  final String name;
  String image;
  final int price;
  final String brand;
  final String shop;
  List<dynamic> sizes;

  ProductData({
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
    required this.shop,
    required this.sizes,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      name: json['name'],
      image: json['image'],
      price: int.parse(json['price'].toString()),
      brand: json['brand'],
      shop: json['shop'],
      sizes: List<dynamic>.from(json['size'].map((x) => x)).cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'brand': brand,
      'shop': shop,
      'size': FieldValue.arrayUnion(sizes),
      'createdAt': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'brand': brand,
      'shop': shop,
      'size': List<dynamic>.from(sizes.map((x) => x.toJson())),
      'updateAt': FieldValue.serverTimestamp(),
    };
  }
}
