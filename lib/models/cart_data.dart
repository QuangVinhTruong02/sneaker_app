import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_data.dart';

class CartData extends ProductData{
  final String idProduct;
  final String name;
  final String image;
  final int price;
  final String brand;
  final int size;
  int quantity;
  bool isSelected;

  CartData({
    required this.idProduct,
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
    required this.size,
    required this.quantity,
    required this.isSelected,
     List<dynamic>? sizez,
  }): super(name: name, brand: brand, image: image, price: price, sizez: sizez);

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      idProduct: json['idProduct'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      brand: json['brand'],
      size: json['size'],
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
      'quantity': quantity,
      'isSelected': isSelected,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
