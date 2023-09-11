import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/order_data.dart';

import '../../../service/firestore_service/firestore_order.dart';
import '../text_style.dart';

class OrderConfirm extends StatelessWidget {
  final String shopName;
  const OrderConfirm({super.key, required this.shopName});

  @override
  Widget build(BuildContext context) {
    List<OrderData>? orderList;
    List<String>? Ids;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("shopName", isEqualTo: shopName)
            .where("status", isEqualTo: false)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            orderList = FirestoreOrder().getListOrder(snapshot.data?.docs);
            Ids = FirestoreOrder().getIdOrderList(snapshot.data?.docs);
            if (orderList!.length > 0) {
              return ListView.builder(
                itemCount: orderList!.length,
                itemBuilder: (context, index) {
                  OrderData orderData = orderList![index];

                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
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
                            imageUrl: orderData.image,
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    "Khách hàng: ${orderData.nameUser}",
                                    style: textStyleApp(
                                      FontWeight.bold,
                                      Colors.black,
                                      16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  orderData.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyleApp(
                                    FontWeight.w700,
                                    Colors.black,
                                    16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Size: ${orderData.size}',
                                  style: textStyleApp(
                                    FontWeight.normal,
                                    Colors.grey,
                                    16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'x${orderData.quantity}',
                                      style: textStyleApp(
                                        FontWeight.normal,
                                        Colors.grey,
                                        16,
                                      ),
                                    ),
                                    Text(
                                      '${formaCurrencyText(orderData.price)}',
                                      style: textStyleApp(
                                        FontWeight.w500,
                                        Colors.black,
                                        16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Thành tiền: ${formaCurrencyText(orderData.quantity * orderData.price)}",
                                    style: textStyleApp(
                                      FontWeight.w500,
                                      Colors.black,
                                      16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                        ))),
                                    onPressed: () {
                                      FirestoreOrder()
                                          .updateOrder(Ids![index], context);
                                    },
                                    child: Text(
                                      "Xác nhận",
                                      style: textStyleApp(
                                        FontWeight.bold,
                                        Colors.white,
                                        14,
                                      ),
                                    ),
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
              );
            } else {
              return Center(
                child: Image.asset('assets/images/no_product_found.png'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
