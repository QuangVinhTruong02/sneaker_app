import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/user_data.dart';

class FirestoreUser {
  final _users = FirebaseFirestore.instance.collection('users');
  static late String idUser;
  //get item list

  //get item
  void getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser!.email.toString();
    _users.where("email", isEqualTo: user).get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              idUser = document.reference.id;
            },
          ),
        );
  }

  Future updateDetailUser(UserData user, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await _users.doc(idUser).update(user.toJsonUpdate());
    } catch (e) {
      e.toString();
    }

    Navigator.pop(context);
    Navigator.pop(context);
  }
}
