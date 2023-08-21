import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String nameText;
  const TextfieldWidget({
    super.key,
    required this.nameText,
    required this.controller,
  });

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: Colors.black,
      obscureText: 'Password' == widget.nameText && !_visibility ? true : false,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.black)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.black)),
          hintText: widget.nameText,
          focusColor: Colors.black,
          suffixIcon: widget.nameText == 'Password'
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _visibility = !_visibility;
                    });
                  },
                  icon: !_visibility
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null),
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersiveSticky,
        );
      },
    );
  }
}
