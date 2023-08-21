import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/user_data.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future SignIn(BuildContext context, String email, String password) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) { 
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sai emai hoặc mật khẩu')));
    });
  }

  Future SignUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String phone,
    String address,
    BuildContext context,
  ) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      UserData user = UserData(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address,
      );
      await FirebaseFirestore.instance.collection('users').add(user.toJson());
      //     {
      //   'email': email,
      //   'firstName': firstName,
      //   'lastName': lastName,
      //   'phone': phone,
      //   'address': address,
      //   'createdAt': FieldValue.serverTimestamp(),
      //   'updateAt': FieldValue.serverTimestamp(),
      // }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công'),
        ),
      );
      SignOut();
      Navigator.pop(context);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tài khoản đã có người đăng ký'),
        ),
      );
    });
  }

  Future ForgotPassword(String email, BuildContext context) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Mã đã được gửi về địa chỉ email của bạn! Vui lòng vào gmail để đổi mật khẩu'),
        ),
      );
    });
  }

  void SignOut() {
    _firebaseAuth.signOut();
  }
}
