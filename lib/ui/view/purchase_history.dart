import 'package:flutter/material.dart';
import 'package:sneaker_app/ui/widget/purchase_history/list_of_order.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory>
    with TickerProviderStateMixin {
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
              top: MediaQuery.of(context).size.height * 0.005,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    "Lịch sử thanh toán",
                    style: textStyleApp(
                      FontWeight.bold,
                      Colors.white,
                      20,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.92,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    TabBar(
                      labelColor: Colors.white,
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      labelStyle:
                          textStyleApp(FontWeight.bold, Colors.white, 18),
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Text("Đã thanh toán"),
                        Text("Chưa thanh toán"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListOfOrder(status: true),
                          ListOfOrder(status: false),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
