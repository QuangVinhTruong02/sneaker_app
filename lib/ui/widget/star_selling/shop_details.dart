import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../text_style.dart';

class ShopDetails extends StatelessWidget {
  final String name;
  final TextEditingController _nameController;
  const ShopDetails({
    super.key,
    required this.name,
    required TextEditingController shopNameController,
  }) : _nameController = shopNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            "$name:",
            style: textStyleApp(
              FontWeight.bold,
              Colors.black,
              20,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "$name",
            ),
            onTap: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
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
      ],
    );
  }
}
