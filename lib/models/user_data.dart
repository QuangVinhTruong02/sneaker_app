import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
   String email;
   String firstName;
   String lastName;
   String phone;
   String address;
  UserData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

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

  Map<String, dynamic> toJsonUpdate() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
