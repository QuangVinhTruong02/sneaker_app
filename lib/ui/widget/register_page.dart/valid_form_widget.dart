import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidFormWidget extends StatefulWidget {
  final Stream stream;
  final TextEditingController controller;
  final String nameText;
  final Sink sink;
  ValidFormWidget({
    super.key,
    required this.stream,
    required this.controller,
    required this.nameText,
    required this.sink,
  });

  @override
  State<ValidFormWidget> createState() => _ValidFormWidgetState();
}

class _ValidFormWidgetState extends State<ValidFormWidget> {
  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return TextField(
          controller: widget.controller,
          cursorColor: Colors.black,
          obscureText: (('Password' == widget.nameText ||
                      'Confirm password' == widget.nameText) &&
                  !_visibility)
              ? true
              : false,
          keyboardType:
              'Phone' == widget.nameText ? TextInputType.number : null,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black)),
              hintText: widget.nameText,
              focusColor: Colors.black,
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              suffixIcon: widget.nameText == 'Password' ||
                      widget.nameText == 'Confirm password'
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _visibility = !_visibility;
                        });
                      },
                      icon: !_visibility
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    )
                  : null),
          onChanged: (value) => widget.sink.add(value),
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
      },
    );
  }
}
