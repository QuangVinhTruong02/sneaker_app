import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../../controller/cart_notifier.dart';
import '../../../service/firestore_service/firestore_user/firestore_cart.dart';
import '../../../service/firestore_service/firestore_user/firestore_user.dart';
import '../text_style.dart';
import 'item_of_cart.dart';

class QuantityOfItem extends StatelessWidget {
  const QuantityOfItem({
    super.key,
    required this.widget,
  });

  final ItemOfCart widget;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartNotifier>(context, listen: false);
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: widget.item.quantity == 1 ? Colors.grey : Colors.black,
            border: Border.all(color: Colors.black),
            shape: BoxShape.rectangle,
          ),
          child: GestureDetector(
            onTap: widget.item.quantity == 1
                ? () {}
                : () {
                    FirestoreCart().decrementItem(
                        widget.idCart, widget.item.quantity, context);
                    if (widget.item.isSelected) {
                      provider.decrementTotal(widget.item.price);
                    }
                  },
            child: Icon(
              MaterialCommunityIcons.minus,
              color: widget.item.quantity == 1 ? Colors.black : Colors.white,
            ),
          ),
        ),
        Container(
          width: 50,
          height: 30,
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.black,
              ),
            ),
            shape: BoxShape.rectangle,
          ),
          child: Text(
            '${widget.item.quantity}',
            style: textStyleApp(
              FontWeight.normal,
              Colors.black,
              20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black),
            shape: BoxShape.rectangle,
          ),
          child: GestureDetector(
            onTap: () {
              FirestoreCart()
                  .incrementItem(widget.idCart, widget.item.quantity, context);

              if (widget.item.isSelected) {
                provider.incrementTotal(widget.item.price);
              }
            },
            child: const Icon(
              MaterialCommunityIcons.plus,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
