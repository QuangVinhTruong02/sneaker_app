import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/models/order_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_order.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/view/purchase_history.dart';

import '../../../controller/cart_notifier.dart';
import '../../../models/cart_data.dart';
import '../../../service/firestore_service/firestore_user/firestore_cart.dart';
import '../text_style.dart';

class PayCartBar extends StatefulWidget {
  const PayCartBar({
    super.key,
    required this.Ids,
    required this.cartList,
  });

  final List<String> Ids;
  final List<CartData> cartList;

  @override
  State<PayCartBar> createState() => _PayCartBarState();
}

class _PayCartBarState extends State<PayCartBar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartNotifier>(context, listen: false).setTotal = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool check = widget.cartList.any((element) => element.isSelected == true);

    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        print(FirestoreUser.fullNameUser);
        // if (widget.cartList.every((element) => element.isSelected == false)) {
        //   cartNotifier.setTotal = 0;
        // }
        return Row(
          children: [
            Checkbox(
              value: cartNotifier.isAllChecked,
              onChanged: (checked) {
                for (var element in widget.Ids) {
                  FirestoreCart().updateCheckedItemOfCart(element, checked!);
                }

                cartNotifier.isAllChecked = checked!;

                if (checked == true) {
                  for (var element in widget.cartList) {
                    if (element.isSelected != true) {
                      cartNotifier.incrementTotal(element.total!);
                    }
                  }
                } else {
                  for (var element in widget.cartList) {
                    cartNotifier.decrementTotal(element.total!);
                  }
                }
              },
            ),
            Text(
              'Chọn tất cả',
              style: textStyleApp(
                FontWeight.normal,
                Colors.black,
                15,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      'Tổng cộng',
                      style: textStyleApp(
                        FontWeight.normal,
                        Colors.black,
                        18,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      formaCurrencyText(cartNotifier.getTotal),
                      textScaleFactor: 1,
                      style: textStyleApp(
                        FontWeight.normal,
                        Colors.black,
                        18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 28),
            GestureDetector(
              onTap: check
                  ? () async {
                      List<String> deleteList = List.empty(growable: true);
                      for (int i = 0; i < widget.cartList.length; i++) {
                        if (widget.cartList[i].isSelected == true) {
                          OrderData orderData = OrderData(
                            idProduct: widget.cartList[i].idProduct,
                            name: widget.cartList[i].name,
                            image: widget.cartList[i].image,
                            price: widget.cartList[i].price,
                            brand: widget.cartList[i].brand,
                            size: widget.cartList[i].size,
                            shopName: widget.cartList[i].shopName,
                            quantity: widget.cartList[i].quantity,
                            status: false,
                            emailUser: FirestoreUser.email,
                            nameUser: FirestoreUser.fullNameUser,
                          );
                          deleteList.add(widget.Ids[i]);
                          await FirestoreOrder().addOrder(orderData, context);
                        }
                      }
                      deleteList.forEach((element) async {
                        await FirestoreCart().deleteItemOfCart(element);
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseHistory()),
                      );
                    }
                  : () {},
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Mua hàng",
                    style: textStyleApp(
                      FontWeight.bold,
                      Colors.white,
                      18,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
