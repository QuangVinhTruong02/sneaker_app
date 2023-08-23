import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneaker_app/ui/widget/search_page/product_list.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

import '../../models/product_data.dart';
import '../../service/firestore_service/firestore_product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<ProductData>> _products;
  String search = "";
  void _getList() {
    _products = FirestoreProduct().getList();
  }

  @override
  void initState() {
    _getList();
    super.initState();
  }

  late List<ProductData> _productList;
  List<ProductData> _productListTemp = List.empty(growable: true);

  List<ProductData> _runFilter(List<ProductData> list) {
    List<ProductData> results = List.empty(growable: true);
    if (search.isEmpty) {
      results = list;
    } else {
      results = list
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
      // print(results[0].name);
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Image.asset('assets/images/top_image.png'),
          FutureBuilder(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _productList = snapshot.data ?? [];

                _productListTemp = _runFilter(snapshot.data!);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Text(
                        "Search",
                        style: textStyleApp(FontWeight.bold, Colors.white, 42),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: TextField(
                        onSubmitted: (value) {
                          search = value;
                          print("Changed: " + value);
                          
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          hintText: 'Search',
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.manual,
                              overlays: [SystemUiOverlay.bottom]);
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.immersive,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.9 / 2,
                          crossAxisCount: 2,
                        ),
                        itemCount: _productListTemp.length,
                        itemBuilder: (context, index) {
                          print(
                              "set ok: " + _productListTemp.length.toString());
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
                                        image: NetworkImage(
                                            _productListTemp[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    _productListTemp[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: textStyleApp(
                                        FontWeight.w700, Colors.black, 18),
                                  ),
                                  Text(
                                    formaCurrencyText(
                                        _productListTemp[index].price),
                                    style: textStyleApp(
                                        FontWeight.w400, Colors.black, 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
