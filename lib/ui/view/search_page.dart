import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneaker_app/ui/view/product_detail_page.dart';
import 'package:sneaker_app/ui/widget/home_page/custom_search.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

import '../../models/product_data.dart';
import '../../service/firestore_service/firestore_product.dart';

class SearchPage extends StatefulWidget {
  final String suggestion;
  const SearchPage({super.key, required this.suggestion});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // late Future<List<ProductData>> _products;
  // String search = "";
  // void _getList() {
  //   _products = FirestoreProduct().getList(widget.suggestion.toString());
  // }

  @override
  void initState() {
    //_getList();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
    );
    super.initState();
  }

  List<ProductData> _productList = List.empty(growable: true);
  List<String> _IdList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final _nameCotroller = TextEditingController();
    _nameCotroller.text = widget.suggestion;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Image.asset('assets/images/top_image.png'),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("products").get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                snapshot.data!.docs.forEach((element) {
                  if (element
                      .data()["name"]
                      .toString()
                      .toLowerCase()
                      .contains(widget.suggestion.toLowerCase())) {
                    _productList.add(ProductData.fromJson(element.data()));
                    _IdList.add(element.id);
                  }
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Search",
                            style:
                                textStyleApp(FontWeight.bold, Colors.white, 42),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: _nameCotroller,
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
                          showSearch(
                            context: context,
                            delegate: CustomSearch(),
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
                        itemCount: _productList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              ProductData product;
                              product = await FirestoreProduct()
                                  .getProduct(_IdList[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    product: product,
                                    idProduct: _IdList[index],
                                  ),
                                ),
                              );
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
                                            _productList[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    _productList[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: textStyleApp(
                                        FontWeight.w700, Colors.black, 18),
                                  ),
                                  Text(
                                    formaCurrencyText(
                                        _productList[index].price),
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
