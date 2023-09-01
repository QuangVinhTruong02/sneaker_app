import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/shop_information.dart';

import '../../ui/view/shop_page.dart';

class FirestoreShop {
  final _shop = FirebaseFirestore.instance.collection("shops");
  Future addShop(ShopInformation shop, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await _shop
        .where("shopName", isEqualTo: shop.shopName)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        await _shop.add(shop.toJson());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Đăng ký shop thành công"),
          ),
          
        );
        Navigator.pop(context);
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ShopPage(),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Tên shop trùng với tên đã được sử dụng/đăng ký trước đó"),
          ),
        );
        Navigator.pop(context);
      }
    });
  }
}
