import 'package:flutter/material.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

class ShopFunction extends StatelessWidget {
  final int value;
  final String image;
  final String name;
  const ShopFunction({super.key, required this.image, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 2,
          )
        ],
      ),
      child: GestureDetector(
        onTap: () {
          print("ok");
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              FittedBox(
                child: Text(
                  name,
                  style: textStyleApp(
                    FontWeight.bold,
                    Colors.black,
                    20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
