import 'package:flutter/material.dart';
import 'package:sneaker_app/service/firestore_service.dart';
import 'package:sneaker_app/ui/view/product_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/product_data.dart';
import '../text_style.dart';

class SuggestionToBuyList extends StatelessWidget {
  const SuggestionToBuyList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ProductData>? products =
              FirestoreService().getProducts(snapshot.data?.docs);
          return GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.9 / 2,
              crossAxisCount: 2,
            ),
            itemCount: products?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        product: products[index],
                        idProduct: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          offset: Offset(1, 0))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(products![index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        products[index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textStyleApp(FontWeight.w700, Colors.black, 18),
                      ),
                      Text(
                        '${products[index].price}.000₫',
                        style: textStyleApp(FontWeight.w400, Colors.black, 15),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
