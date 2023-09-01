import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_app/models/cart_data.dart';

class OrderData extends CartData {
  final bool status;
  final String emailUser;
  final String nameUser;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  OrderData({
    required super.idProduct,
    required super.name,
    required super.image,
    required super.price,
    required super.brand,
    required super.size,
    required super.shopName,
    required super.quantity,
    required this.status,
    required this.emailUser,
    required this.nameUser,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      idProduct: json['idProduct'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      brand: json['brand'],
      size: json['size'],
      shopName: json['shopName'],
      quantity: json['quantity'],
      status: json['status'],
      emailUser: json['emailUser'],
      nameUser: json['nameUser'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
      'status': status,
      'emailUser': emailUser,
      'nameUser': nameUser,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
