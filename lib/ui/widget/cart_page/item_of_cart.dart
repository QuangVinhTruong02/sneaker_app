import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/cart_notifier.dart';
import 'package:sneaker_app/models/product_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_product.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user.dart';
import 'package:sneaker_app/ui/view/product_detail_page.dart';

import '../../../models/cart_data.dart';
import '../text_style.dart';

class ItemOfCart extends StatefulWidget {
  ItemOfCart({
    super.key,
    required this.item,
    required this.idCart,
    required this.alow,
  });

  final CartData item;
  final String idCart;
  bool alow;

  @override
  State<ItemOfCart> createState() => _ItemOfCartState();
}

class _ItemOfCartState extends State<ItemOfCart> {
  @override
  void initState() {
    if (widget.item.isSelected == true) {
      FirestoreUser().updateCheckedItemOfCart(widget.idCart, false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool check = widget.alow;
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
                FirestoreUser().deleteItemOfCart(widget.idCart);
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
                  quantity: widget.item.quantity,
                  size: widget.item.size,
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
                    FirestoreUser()
                        .updateCheckedItemOfCart(widget.idCart, checked!);
                    check = checked;
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
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: widget.item.quantity == 1
                                  ? Colors.grey
                                  : Colors.blue[400],
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.rectangle,
                            ),
                            child: GestureDetector(
                              onTap: widget.item.quantity == 1
                                  ? () {}
                                  : () {
                                      FirestoreUser().decrementItem(
                                          widget.idCart,
                                          widget.item.quantity,
                                          context);
                                      if (widget.item.isSelected) {
                                        provider
                                            .decrementTotal(widget.item.price);
                                      }
                                    },
                              child: const Icon(
                                MaterialCommunityIcons.minus,
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
                              color: Colors.blue[400],
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.rectangle,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                FirestoreUser().incrementItem(widget.idCart,
                                    widget.item.quantity, context);

                                if (widget.item.isSelected) {
                                  provider.incrementTotal(widget.item.price);
                                }
                              },
                              child: const Icon(
                                MaterialCommunityIcons.plus,
                              ),
                            ),
                          ),
                        ],
                      ),

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
