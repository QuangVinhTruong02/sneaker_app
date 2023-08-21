import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  UserData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  }
  );

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        address: json['address'],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
