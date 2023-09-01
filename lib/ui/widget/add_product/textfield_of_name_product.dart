import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldOfNameProduct extends StatelessWidget {
  const TextFieldOfNameProduct({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hintText: "Nhập tên sản phẩm",
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
    );
  }
}
