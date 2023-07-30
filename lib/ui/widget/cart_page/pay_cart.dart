import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/cart_notifier.dart';
import '../../../models/cart_data.dart';
import '../../../service/firestore_service.dart';
import '../text_style.dart';

class PayCart extends StatelessWidget {
  const PayCart({
    super.key,
    required this.Ids,
    required this.cartList,
  });

  final List<String> Ids;
  final List<CartData>? cartList;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return Row(
          children: [
            Checkbox(
              value: cartNotifier.isAllChecked,
              onChanged: (checked) {
                cartNotifier.isAllChecked = checked!;
                for (var element in Ids) {
                  FirestoreService().updateCheckedItemOfCart(element, checked);
                }
                for (var element in cartList!) {
                  int amount = element.price * element.quantity;
                  cartNotifier.total(amount, checked);
                }
              },
            ),
            Text(
              'Select All',
              style: textStyleApp(
                FontWeight.normal,
                Colors.black,
                18,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: textStyleApp(
                      FontWeight.normal,
                      Colors.black,
                      18,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      "${cartNotifier.getTotal}.000₫",
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
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: const BoxDecoration(
                color: Colors.blue,
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
            )
          ],
        );
      },
    );
  }
}
