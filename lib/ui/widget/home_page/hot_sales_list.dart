import 'package:flutter/material.dart';
import 'package:sneaker_app/service/firestore_service/firestore_product.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user.dart';
import 'package:sneaker_app/ui/view/product_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/product_data.dart';
import '../text_style.dart';

class HotSalesList extends StatelessWidget {
  const HotSalesList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    List<ProductData>? list;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("products")
          .orderBy("price", descending: true)
          .limit(10)
          .snapshots(),
      // FutureBuilder(
      //   future: FirebaseFirestore.instance
      //       .collection("products")
      //       .orderBy("price", descending: true)
      //       .limit(10)
      //       .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          list = FirestoreProduct().getProducts(snapshot.data?.docs);
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async{
                    ProductData product;
                    product = await FirestoreProduct().getProduct(snapshot.data!.docs[index].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: product,
                          idProduct: snapshot.data!.docs[index].id,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 1,
                            blurRadius: 0.6,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(list![index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text(
                                    list![index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: textStyleApp(
                                      FontWeight.bold,
                                      Colors.black,
                                      24,
                                    ),
                                  ),
                                ),
                                Text(
                                  formaCurrencyText(list![index].price),
                                  style: textStyleApp(
                                      FontWeight.w600, Colors.black, 24),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
