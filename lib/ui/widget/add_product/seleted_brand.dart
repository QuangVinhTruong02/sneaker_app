
import 'package:flutter/material.dart';

import '../text_style.dart';

class SelectedBrand extends StatefulWidget {
  SelectedBrand({
    super.key,
    required this.brand,
    required String selectedType,
    required this.onChanged,
  }) : _selectedType = selectedType;

  final Future<List<String>> brand;
  String _selectedType;
  final Function(String) onChanged;

  @override
  State<SelectedBrand> createState() => _SelectedBrandState();
}

class _SelectedBrandState extends State<SelectedBrand> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.brand,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<String> _brands = ["Another"];
          _brands.addAll(snapshot.data!);

          return SizedBox(
            width: 150,
            height: 50,
            child: DropdownButton(
              isExpanded: true,
              items: _brands.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                widget._selectedType,
                style: textStyleApp(
                  FontWeight.normal,
                  Colors.black,
                  15,
                ),
              ),
              onChanged: (value) {
                // setState(() {
                //   widget._selectedType = value!;
                // });
                widget.onChanged(value!);
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
