import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/cart_notifier.dart';
import 'package:sneaker_app/models/cart_data.dart';
import 'package:sneaker_app/service/firestore_service.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

import '../widget/cart_page/item_of_cart.dart';
import '../widget/cart_page/pay_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartData>? cartList;
  List<String> Ids = List.empty(growable: true);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartNotifier>(context, listen: false).amount = 0;
      Provider.of<CartNotifier>(context, listen: false).isAllChecked = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Image.asset('assets/images/top_image.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                child: Text(
                  'My Cart',
                  style: textStyleApp(FontWeight.bold, Colors.white, 42),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirestoreService.idUser)
                      .collection("cart")
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      cartList =
                          FirestoreService().getCarts(snapshot.data?.docs);
                      if (cartList!.length == 0) {
                        return Center(
                          child: Image.asset('assets/images/empty-cart.png'),
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: cartList!.length,
                                itemBuilder: (context, index) {
                                  String id = snapshot.data!.docs[index].id;
                                  Ids.add(id);
                                  // CartData item = ;
                                  return ItemOfCart(
                                    item: cartList![index],
                                    id: id,
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              padding: const EdgeInsets.all(8),
                              //width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(4, -10),
                                  )
                                ],
                              ),
                              child: PayCart(Ids: Ids, cartList: cartList),
                            ),
                          ],
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
