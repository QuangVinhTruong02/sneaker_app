import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/product_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';

class FirestoreProduct {
  final _products = FirebaseFirestore.instance.collection('products');
  static List<String> brands = List.empty(growable: true);
  // get all items
  List<ProductData>? getProducts(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    List<ProductData>? topList;
    topList = docs
        ?.map(
            (documentSnapshot) => ProductData.fromJson(documentSnapshot.data()))
        .toList();
    return topList;
  }

  //get item
  Future<ProductData> getProduct(String idProduct) async {
    late ProductData product;
    await _products.doc(idProduct).get().then((value) {
      product = ProductData.fromJson(value.data()!);
    });
    return product;
  }

  List<String> getBrand(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    List<String> result;
    List<String>? tempList;
    tempList = docs!
        .map((documentSnapshot) => documentSnapshot.data()["brand"])
        .cast<String>()
        .toList();
    result = tempList.toSet().toList();
    return result;
  }

  Future<List<String>> getB() async {
    List<String> brandList = [];
    await FirebaseFirestore.instance.collection("products").get().then((value) {
      brandList = value.docs
          .map((documentSnapshot) => documentSnapshot.data()["brand"])
          .cast<String>()
          .toSet()
          .toList();
    });
    return brandList;
  }

  Future addProduct(ProductData product, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    String imageUrl = '';
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage =
        reference.child(FirestoreUser.email).child("MyShop");
    Reference referenceToUpload = referenceDirImage.child(product.name);
    try {
      await referenceToUpload.putFile(File(product.image));
      imageUrl = await referenceToUpload.getDownloadURL();
      product.image = imageUrl;
    } catch (e) {
      e.toString();
    }

    await _products.add(product.toJson());
    Navigator.pop(context);
  }
}
