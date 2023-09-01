import 'package:cloud_firestore/cloud_firestore.dart';

class CartData {
  final String idProduct;
  final String name;
  final String image;
  final int price;
  final String brand;
  final int size;
  final String shopName;
  int quantity;
   bool? isSelected;
  int? total;

  CartData({
    required this.idProduct,
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
    required this.size,
    required this.shopName,
    required this.quantity,
    this.isSelected,
  }) : total = quantity * price;

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      idProduct: json['idProduct'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      brand: json['brand'],
      size: json['size'],
      shopName: json['shopName'],
      quantity: json['quantity'],
      isSelected: json['isSelected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProduct': idProduct,
      'name': name,
      'image': image,
      'price': price,
      'brand': brand,
      'size': size,
      'shopName': shopName,
      'quantity': quantity,
      'isSelected': isSelected,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
