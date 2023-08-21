import 'package:flutter/material.dart';

import '../widget/home_page/hot_sales_list.dart';
import '../widget/home_page/suggestion_to_buy_list.dart';
import '../widget/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Image.asset('assets/images/top_image.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                child: Text(
                  'Collection shoes',
                  style: textStyleApp(FontWeight.bold, Colors.white, 42),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Hot sales',
                            style:
                                textStyleApp(FontWeight.w500, Colors.white, 30),
                          ),
                          Image.asset('assets/images/hot_sales.png'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
                        // get top list products
                        child: HotSalesList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Buying Suggestions',
                        style: textStyleApp(FontWeight.w500, Colors.black, 18),
                      ),
                    ),
                    const SizedBox(height: 5),
                    //get all list products
                    const SuggestionToBuyList()
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
