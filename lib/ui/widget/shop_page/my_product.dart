import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.9 / 2,
                      crossAxisCount: 2,
                    ),
                    itemCount: products?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          // ProductData product;
                          // product = await FirestoreProduct()
                          //     .getProduct(snapshot.data!.docs[index].id);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductDetailPage(
                          //       product: product,
                          //       idProduct: snapshot.data!.docs[index].id,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(products![index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                products[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textStyleApp(
                                    FontWeight.w700, Colors.black, 18),
                              ),
                              Text(
                                formaCurrencyText(products[index].price),
                                style: textStyleApp(
                                    FontWeight.w400, Colors.black, 16),
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
