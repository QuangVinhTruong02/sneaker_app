import 'dart:io';

import 'package:flutter/material.dart';

import '../text_style.dart';

class ShopLogo extends StatelessWidget {
  const ShopLogo({
    super.key,
    required this.imageLocal, required this.avatar, required this.onPressed,
  });

  final String imageLocal;
  final String avatar;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      // shop logo
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Shop Logo",
            style: textStyleApp(
              FontWeight.bold,
              Colors.black,
              20,
            ),
          ),
          // logo
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 35,
                child: CircleAvatar(
                  backgroundImage: imageLocal == ""
                      ? NetworkImage(avatar)
                      : FileImage(File(imageLocal)) as ImageProvider,
                  radius: 34,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
