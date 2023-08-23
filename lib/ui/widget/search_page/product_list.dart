import 'package:flutter/material.dart';

import '../../../models/product_data.dart';
import '../text_style.dart';

// ignore: must_be_immutable
class ProductList extends StatefulWidget {
  List<ProductData> productList;
  ProductList({super.key, required this.productList});
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.9 / 2,
        crossAxisCount: 2,
      ),
      itemCount: widget.productList.length,
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
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.white, spreadRadius: 1, offset: Offset(1, 0))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.productList[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.productList[index].name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: textStyleApp(FontWeight.w700, Colors.black, 18),
                ),
                Text(
                  formaCurrencyText(widget.productList[index].price),
                  style: textStyleApp(FontWeight.w400, Colors.black, 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
