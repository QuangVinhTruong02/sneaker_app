import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sneaker_app/service/firestore_service/firestore_product.dart';
import '../../models/product_data.dart';
import '../../service/firestore_service/firestore_user/firestore_user.dart';
import '../widget/add_product/seleted_brand.dart';
import '../widget/add_product/seleted_size_of_admin.dart';
import '../widget/add_product/textfield_of_name_product.dart';
import '../widget/add_product/textfield_of_price.dart';
import '../widget/text_style.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
    required this.shopName,
  });
  final String shopName;
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  late Future<List<String>> brand;

  void getBrand() async {
    brand = FirestoreProduct().getB();
  }

  List<String> sizeList = [
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
  ];
  List<String> selectedSize = List.empty(growable: true);
  String _image = "";
  String _selectedType = "Another";

  void onChangedBrand(String value) {
    setState(() {
      _selectedType = value;
    });
  }

  void onTapSeletedSize(String size) {
    if (!selectedSize.contains(size)) {
      selectedSize.add(size);
      setState(() {});
    } else {
      selectedSize.removeWhere((element) => element == size);
      setState(() {});
    }
  }

  bool checkButton(String image, String nameProduct, String brand,
      List<int> sizeList, String price) {
    if (sizeList.isNotEmpty) {
      sizeList.sort();
    }

    ;
    int? p = int.tryParse(price.replaceAll('.', ''));
    if (image != "" &&
        nameProduct != "" &&
        brand != "" &&
        sizeList.length > 0 &&
        p != null &&
        p != "") {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    getBrand();
    super.initState();
  }

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
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Thêm sản phẩm",
                    style: textStyleApp(
                      FontWeight.bold,
                      Colors.white,
                      20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(16),
                    right: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //pick image
                      Text(
                        "Chọn ảnh: ",
                        style: textStyleApp(
                          FontWeight.bold,
                          Colors.black,
                          20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          onTap: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (file == null) return;
                            _image = file.path;
                          },
                          child: _image == ""
                              ? Image.asset(
                                  "assets/images/add_image.png",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(_image),
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Tên sản phẩm: ",
                        style: textStyleApp(
                          FontWeight.bold,
                          Colors.black,
                          18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // product name
                      TextFieldOfNameProduct(nameController: _nameController),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chọn loại: ",
                            style: textStyleApp(
                              FontWeight.bold,
                              Colors.black,
                              18,
                            ),
                          ),
                          //brand
                          SelectedBrand(
                            brand: brand,
                            selectedType: _selectedType,
                            onChanged: onChangedBrand,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        "Chọn Size: ",
                        style: textStyleApp(
                          FontWeight.bold,
                          Colors.black,
                          18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SeletedSizeOfAdmin(
                          sizeList: sizeList,
                          selectedSize: selectedSize,
                          onTapSeletedSize: onTapSeletedSize),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        "Giá: ",
                        style: textStyleApp(
                          FontWeight.bold,
                          Colors.black,
                          18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextfieldOfPrice(priceController: _priceController),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            )),
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 10),
                            ),
                            backgroundColor: MaterialStatePropertyAll(
                              checkButton(
                                      _image,
                                      _nameController.text,
                                      _selectedType,
                                      selectedSize.cast<int>(),
                                      _priceController.text)
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          onPressed: checkButton(
                                  _image,
                                  _nameController.text,
                                  _selectedType,
                                  selectedSize.cast<int>(),
                                  _priceController.text)
                              ? () {
                                  
                                 
                                  ProductData productData = ProductData(
                                      name: _nameController.text,
                                      image: _image,
                                      price: int.parse(_priceController.text
                                          .replaceAll('.', '')),
                                      brand: _selectedType,
                                      shop: widget.shopName,
                                      sizes: selectedSize);
                                  FirestoreProduct()
                                      .addProduct(productData, context);
                                }
                              : () {},
                          child: Text(
                            "Thêm sản phẩm",
                            style:
                                textStyleApp(FontWeight.bold, Colors.white, 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
