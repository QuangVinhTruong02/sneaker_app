import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? email;
  String? firstName;
  String? lastName;
  String phone;
  String address;
  String? avatar;
  UserData({
     this.email,
     this.firstName,
     this.lastName,
    required this.phone,
    required this.address,
    this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        address: json['address'],
        avatar: json['avatar'] ?? null
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'avatar': avatar,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'avatar': avatar,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
