import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/order_data.dart';

class FirestoreOrder {
  final _order = FirebaseFirestore.instance.collection("orders");

  Future addOrder(OrderData orderData, BuildContext context) async {
    await _order.add(orderData.toJson());
  }

  List<OrderData>? getListOrder(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    List<OrderData>? orders;
    orders = docs
        ?.map((documentSnapshot) => OrderData.fromJson(documentSnapshot.data()))
        .toList();

    return orders;
  }

  List<OrderData>? getIdOrderList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    List<OrderData>? orders;
    orders = docs
        ?.map((documentSnapshot) => OrderData.fromJson(documentSnapshot.data()))
        .toList();
    orders!.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );
    return orders;
  }
}
