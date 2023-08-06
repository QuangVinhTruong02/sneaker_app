import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/cart_data.dart';
import 'package:sneaker_app/models/product_data.dart';

class FirestoreService {
  final _products = FirebaseFirestore.instance.collection('products');
  final _users = FirebaseFirestore.instance.collection('users');
  static late String idUser;
  //get item
  List<ProductData>? getProducts(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    List<ProductData>? topList;
    topList = docs
        ?.map(
            (documentSnapshot) => ProductData.fromJson(documentSnapshot.data()))
        .toList();
    return topList;
  }

  Future<ProductData> getProduct(String idProduct) async {
    late ProductData product;
    await _products.doc(idProduct).get().then((value) {
      product = ProductData.fromJson(value.data()!);
    });
    return product;
  }

  Future<void> addCart(
      CartData cart, String idProduct, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
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

  void updateCheckedItemOfCart(String idCart, bool isChecked) async {
    await _users
        .doc(idUser)
        .collection("cart")
        .doc(idCart)
        .update({"isSelected": isChecked});
  }

  void updateQuantityItemOfCar(String idCart, int value) async {
    await _users
        .doc(idUser)
        .collection("cart")
        .doc(idCart)
        .update({"quantity": value});
  }

  void deleteItemOfCart(String idItem) async {
    await _users.doc(idUser).collection("cart").doc(idItem).delete();
  }
}
