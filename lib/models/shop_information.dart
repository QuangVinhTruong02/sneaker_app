import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_app/models/user_data.dart';

class ShopInformation extends UserData {
  String shopName;
  String shopLogo;
 
  ShopInformation({
    required this.shopName,
    required super.email,
    required super.phone,
    required super.address,
    required this.shopLogo,
  });
  

  factory ShopInformation.fromToJson(Map<String, dynamic> json) {
    return ShopInformation(
      shopName: json["shopName"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      shopLogo: json["shopLogo"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'shopName': shopName,
      'email': email,
      'phone': phone,
      'address': address,
      'shopLogo': shopLogo,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
