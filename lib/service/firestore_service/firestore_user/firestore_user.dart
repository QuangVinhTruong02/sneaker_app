import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/user_data.dart';

class FirestoreUser {
  final _users = FirebaseFirestore.instance.collection('users');
  static late String idUser;
  static late String email;
  static late String fullNameUser;
  //get item list

  //get item
  Future getCurrentUser() async {
    email = FirebaseAuth.instance.currentUser!.email.toString();
    await _users.where("email", isEqualTo: email).get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              idUser = document.reference.id;
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(idUser)
                  .get()
                  .then((value) {
                fullNameUser = value.data()!["firstName"] +
                    " " +
                    value.data()!["lastName"];
              });
              // "${document.data()["firstName"] + [
              //       " "
              //     ] + document.data()["lastName"]}";
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
