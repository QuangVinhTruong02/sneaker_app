import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sneaker_app/models/shop_information.dart';
import 'package:sneaker_app/models/user_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_shop.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/view/shop_page.dart';
import 'package:sneaker_app/ui/widget/star_selling/shop_logo.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

import '../widget/star_selling/shop_details.dart';

class StarSelling extends StatefulWidget {
  final UserData user;
  const StarSelling({super.key, required this.user});

  @override
  State<StarSelling> createState() => _StarSellingState();
}

class _StarSellingState extends State<StarSelling> {
  final _shopNameController = TextEditingController();

  final _phoneShopController = TextEditingController();
  final _addressController = TextEditingController();
  @override
  void initState() {
    _shopNameController.text =
        widget.user.firstName! + " " + widget.user.lastName!;
    _phoneShopController.text = widget.user.phone;
    _addressController.text = widget.user.address;
    super.initState();
  }

  @override
  void dispose() {
    _shopNameController.dispose();

    _phoneShopController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String imageLocal = "";
  String imageUrl = "";

  void _onPressed() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    Navigator.pop(context);
    if (file == null) return;

    imageLocal = file.path;
  }

  Future _onSave(String avatar, BuildContext context) async {
    if (imageLocal != "") {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child(FirestoreUser.email);
      Reference referenceImageToUpload = referenceDirImages.child("shopLogo");
      try {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        await referenceImageToUpload.putFile(File(imageLocal));
        imageUrl = await referenceImageToUpload.getDownloadURL();
        Navigator.pop(context);
      } catch (e) {
        print(
          e.toString(),
        );
      }
    } else {
      imageUrl = avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("image local: ${imageLocal}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                "Đăng ký cửa hàng",
                                style: textStyleApp(
                                  FontWeight.bold,
                                  Colors.white,
                                  20,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                             
                              await _onSave(widget.user.avatar!, context);
                              ShopInformation shopInformation = ShopInformation(
                                shopName: _shopNameController.text,
                                phone: _phoneShopController.text,
                                email: widget.user.email,
                                address: _addressController.text,
                                shopLogo: imageUrl,
                              );
                              FirestoreShop().addShop(shopInformation, context);
                              
                             
                            },
                            child: Text(
                              "Lưu",
                              style: textStyleApp(
                                FontWeight.bold,
                                Colors.white,
                                20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //shop logo
                          ShopLogo(
                              imageLocal: imageLocal,
                              avatar: widget.user.avatar!,
                              onPressed: _onPressed),
                          const SizedBox(
                            height: 20,
                          ),
                          //infomation
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  16,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShopDetails(
                                  name: "Tên shop",
                                  shopNameController: _shopNameController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ShopDetails(
                                  name: "Số điện thoại",
                                  shopNameController: _phoneShopController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ShopDetails(
                                  name: "Địa chỉ",
                                  shopNameController: _addressController,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
