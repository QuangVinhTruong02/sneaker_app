import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sneaker_app/ui/view/add_product.dart';

import '../../../models/product_data.dart';
import '../../../service/firestore_service/firestore_product.dart';
import '../text_style.dart';

class MyProduct extends StatefulWidget {
  final String shopName;
  const MyProduct({super.key, required this.shopName});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(shopName: widget.shopName),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("products")
            .where("shop", isEqualTo: widget.shopName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            List<ProductData>? products =
                FirestoreProduct().getProducts(snapshot.data?.docs);
            return products!.length > 0
                ? ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 4,
                                offset: const Offset(4, 8),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: products[index].image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyleApp(
                                        FontWeight.w700,
                                        Colors.black,
                                        18,
                                      ),
                                    ),

                                    // Text(
                                    //   'Số lượng: ${widget.item.quantity}',
                                    //   style: textStyleApp(
                                    //     FontWeight.w500,
                                    //     Colors.black,
                                    //     18,
                                    //   ),
                                    // ),
                                    // set quantity

                                    const SizedBox(height: 5),
                                    Text(
                                      'Giá: ${formaCurrencyText(products[index].price)}',
                                      style: textStyleApp(
                                        FontWeight.w500,
                                        Colors.black,
                                        18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Image.asset(
                      "assets/images/no_product_found.png",
                      fit: BoxFit.cover,
                    ),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
