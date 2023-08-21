import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/cart_data.dart';
import 'package:sneaker_app/models/product_data.dart';

class FirestoreUser {
  final _users = FirebaseFirestore.instance.collection('users');
  static late String idUser;
  //get item list

  //get item

  Future<void> addCart(
      CartData cart, String idProduct, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await _users.doc(idUser).collection('cart').get().then((querySnapshot) {
        var idCart = querySnapshot.docs.firstWhere((snapshot) =>
            snapshot.data()["idProduct"] == idProduct &&
            snapshot.data()["size"] == cart.size);
        if (idCart.exists) {
          cart.quantity += int.parse(idCart.data()["quantity"].toString());
          _users
              .doc(idUser)
              .collection("cart")
              .doc(idCart.id)
              .update(cart.toJson());
        }
      });
    } catch (e) {
      _users.doc(idUser).collection("cart").add(cart.toJson());
    }

    Navigator.pop(context);
  }

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

  List<CartData>? getCarts(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    List<CartData>? carts;
    carts = docs
        ?.map((documentSnapshot) => CartData.fromJson(documentSnapshot.data()))
        .toList();

    return carts;
  }

  Future<void> updateCheckedItemOfCart(String idCart, bool isChecked) async {
    await _users
        .doc(idUser)
        .collection("cart")
        .doc(idCart)
        .update({"isSelected": isChecked});
  }

  void deleteItemOfCart(String idItem) async {
    await _users.doc(idUser).collection("cart").doc(idItem).delete();
  }

  void incrementItem(String idCart, int value, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    await _users
        .doc(idUser)
        .collection("cart")
        .doc(idCart)
        .update({"quantity": (++value)});
    Navigator.pop(context);
  }

  void decrementItem(String idCart, int value, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    await _users
        .doc(idUser)
        .collection("cart")
        .doc(idCart)
        .update({"quantity": (--value)});
    Navigator.pop(context);
  }
}
