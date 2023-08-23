import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_app/models/product_data.dart';

class FirestoreProduct {
  final _products = FirebaseFirestore.instance.collection('products');
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

  Future<List<ProductData>> getList() async {
    List<ProductData> productList = List.empty(growable: true);
    await _products.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        productList.add(ProductData.fromJson(element.data()));
      });
    });
    return productList;
  }
}
