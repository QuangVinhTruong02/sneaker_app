import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/cart_notifier.dart';
import 'package:sneaker_app/models/product_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_product.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_cart.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/view/product_detail_page.dart';
import 'package:sneaker_app/ui/widget/cart_page/quantity_of_cart.dart';

import '../../../models/cart_data.dart';
import '../text_style.dart';

class ItemOfCart extends StatefulWidget {
  ItemOfCart({
    super.key,
    required this.item,
    required this.idCart,
  });

  final CartData item;
  final String idCart;

  @override
  State<ItemOfCart> createState() => _ItemOfCartState();
}

class _ItemOfCartState extends State<ItemOfCart> {
  @override
  void initState() {
    if (widget.item.isSelected == true) {
      FirestoreCart().updateCheckedItemOfCart(widget.idCart, false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartNotifier>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              padding: const EdgeInsets.all(8),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              onPressed: (context) {
                if (widget.item.isSelected == true) {
                  provider.decrementTotal(widget.item.total!);
                }
                FirestoreCart().deleteItemOfCart(widget.idCart);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Xóa',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () async {
            ProductData? product;
            product =
                await FirestoreProduct().getProduct(widget.item.idProduct);
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  product: product!,
                  idProduct: widget.item.idProduct,
                ),
              ),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
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
                Checkbox(
                  value: widget.item.isSelected,
                  onChanged: (checked) {
                    // provider.checkedList = widget.item.isSelected;
                    FirestoreCart()
                        .updateCheckedItemOfCart(widget.idCart, checked!);

                    if (checked == true) {
                      provider.incrementTotal(widget.item.total!);
                    } else {
                      provider.decrementTotal(widget.item.total!);
                    }
                  },
                ),
                CachedNetworkImage(
                  imageUrl: widget.item.image,
                  height: 120,
                  width: 120,
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        overflow: TextOverflow.ellipsis,
                        style: textStyleApp(
                          FontWeight.w700,
                          Colors.black,
                          18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Size: ${widget.item.size}',
                        style: textStyleApp(
                          FontWeight.normal,
                          Colors.grey,
                          16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Text(
                      //   'Số lượng: ${widget.item.quantity}',
                      //   style: textStyleApp(
                      //     FontWeight.w500,
                      //     Colors.black,
                      //     18,
                      //   ),
                      // ),
                      // set quantity
                      QuantityOfItem(widget: widget),

                      const SizedBox(height: 5),
                      Text(
                        'Giá: ${formaCurrencyText(widget.item.price)}',
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
        ),
      ),
    );
  }
}
