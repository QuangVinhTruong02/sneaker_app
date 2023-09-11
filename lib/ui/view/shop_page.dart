import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sneaker_app/models/shop_information.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/widget/shop_page/my_product.dart';
import 'package:sneaker_app/ui/widget/shop_page/order_confirm.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset('assets/images/top_image.png'),
          Positioned(
            top: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      "Shop của tôi",
                      style: textStyleApp(
                        FontWeight.bold,
                        Colors.white,
                        25,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("shops")
                        .where("email", isEqualTo: FirestoreUser.email)
                        .limit(1)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        ShopInformation shop = ShopInformation.fromToJson(
                            snapshot.data!.docs[0].data());

                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(16),
                              right: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // header
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(16),
                                    right: Radius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 40,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                shop.shopLogo),
                                        radius: 38,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          shop.shopName,
                                          style: textStyleApp(
                                            FontWeight.bold,
                                            Colors.black,
                                            20,
                                          ),
                                        ),
                                        Text(
                                          shop.email!,
                                          style: textStyleApp(
                                            FontWeight.normal,
                                            Colors.grey,
                                            15,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              //function
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TabBar(
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorColor: Colors.black,
                                      controller: _tabController,
                                      labelColor: Colors.black,
                                      labelStyle: textStyleApp(
                                          FontWeight.bold, Colors.black, 15),
                                      unselectedLabelColor: Colors.grey,
                                      tabs: [
                                        Tab(
                                          text: 'Sản phẩm của tôi',
                                        ),
                                        Tab(
                                          text: 'Xác nhận đơn hàng',
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          MyProduct(shopName: shop.shopName),
                                          OrderConfirm(shopName: shop.shopName),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
