import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class TextfieldOfPrice extends StatelessWidget {
  const TextfieldOfPrice({
    super.key,
    required TextEditingController priceController,
  }) : _priceController = priceController;

  final TextEditingController _priceController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        NumberTextInputFormatter(
          decimalDigits: 3,
          decimalSeparator: ',',
          groupDigits: 3,
          groupSeparator: '.',
        )
      ],
      onChanged: (value) {
        print(value);
      },
      controller: _priceController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hintText: "Nhập giá tiền của sản phẩm",
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
