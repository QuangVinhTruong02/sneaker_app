import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/product_notifier.dart';

import 'package:sneaker_app/ui/widget/text_style.dart';

class ChooseQuantityWidget extends StatefulWidget {
  final int? quantity;
  const ChooseQuantityWidget({
    super.key,
    this.quantity,
  });

  @override
  State<ChooseQuantityWidget> createState() => _ChooseQuantityWidgetState();
}

class _ChooseQuantityWidgetState extends State<ChooseQuantityWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.quantity != null) {
        Provider.of<ProductNotifier>(context, listen: false).quantity =
            widget.quantity!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Chọn số lượng: ',
          style: textStyleApp(FontWeight.normal, Colors.black, 18),
        ),
        Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
            return Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: productNotifier.quantity == 1
                        ? Colors.grey
                        : Colors.blue[400],
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.rectangle,
                  ),
                  child: GestureDetector(
                    onTap: productNotifier.quantity == 1
                        ? () {}
                        : () {
                            productNotifier.decrement();
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
                    '${productNotifier.quantity}',
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
                      productNotifier.increment();
                    },
                    child: const Icon(
                      MaterialCommunityIcons.plus,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
