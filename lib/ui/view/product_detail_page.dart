import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/product_notifier.dart';
import 'package:sneaker_app/models/cart_data.dart';
import 'package:sneaker_app/models/product_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user.dart';
import 'package:sneaker_app/ui/widget/product_detail_page/choose_quantity_widget.dart';
import 'package:sneaker_app/ui/widget/product_detail_page/select_size_widget.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductData product;
  final String idProduct;
  final int? quantity;
  final int? size;
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.idProduct,
    this.quantity,
    this.size,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            //leadingWidth: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                provider.index = 0;
                provider.quantity = 1;
                provider.sizeList.clear();
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            pinned: true,
            snap: false,
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(widget.product.image),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                widget.product.name,
                                maxLines: 2,
                                style: textStyleApp(
                                    FontWeight.bold, Colors.black, 25),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Giá: ${widget.product.price}.000₫',
                                style: textStyleApp(
                                    FontWeight.w600, Colors.black, 20),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Chọn size:",
                                style: textStyleApp(
                                  FontWeight.normal,
                                  Colors.black,
                                  18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              //select size
                              SelectSizeWidget(
                                list: widget.product.sizes as List<int>,
                                size: widget.size,
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(height: 5),
                              //choose quantity
                              ChooseQuantityWidget(quantity: widget.quantity),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    CartData cart = CartData(
                                      idProduct: widget.idProduct,
                                      name: widget.product.name,
                                      image: widget.product.image,
                                      price: widget.product.price,
                                      brand: widget.product.brand,
                                      size: provider.value,
                                      quantity: provider.quantity,
                                      isSelected: false,
                                    );
                                    FirestoreUser().addCart(
                                        cart, widget.idProduct, context);
                                    Navigator.pop(context);
                                    provider.index = 0;
                                    provider.quantity = 1;
                                    provider.sizeList.clear();
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Thêm vào giỏ hàng',
                                        style: textStyleApp(
                                          FontWeight.bold,
                                          Colors.black,
                                          15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
