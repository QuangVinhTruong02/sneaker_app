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

  List<String>? getIdOrderList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    List<String>? orders;
    orders =
        docs?.map((documentSnapshot) => documentSnapshot.reference.id).toList();

    return orders;
  }

  Future updateOrder(String id, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    _order.doc(id).update({'status': true});
    Navigator.pop(context);
  }
}
