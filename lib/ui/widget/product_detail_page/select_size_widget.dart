import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/product_notifier.dart';

import 'package:sneaker_app/ui/widget/text_style.dart';

class SelectSizeWidget extends StatefulWidget {
  final List<int> list;

  const SelectSizeWidget({
    super.key,
    required this.list,
  });

  @override
  State<SelectSizeWidget> createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductNotifier>(context, listen: false).sizeList =
          widget.list;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Consumer<ProductNotifier>(
        builder: (context, productNotifier, child) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: productNotifier.sizeList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ChoiceChip(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  selectedColor: Colors.black,
                  label: Text(
                    "${productNotifier.sizeList[index]}",
                  ),
                  labelStyle: textStyleApp(
                      FontWeight.normal,
                      productNotifier.index == index
                          ? Colors.white
                          : Colors.black,
                      18),
                  selected: productNotifier.index == index,
                  onSelected: (selected) {
                    productNotifier.index = index;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
