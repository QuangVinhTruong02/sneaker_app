import 'package:flutter/material.dart';
import 'package:sneaker_app/service/firestore_service.dart';
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
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("products")
          .orderBy("price", descending: true)
          .limit(10)
          .get(),
      builder: (context, snapshot) {
        List<ProductData>? list =
            FirestoreService().getProducts(snapshot.data?.docs);
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: list[index],
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
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text(
                                    list[index].name,
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
                                  '${list[index].price}.000₫',
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
