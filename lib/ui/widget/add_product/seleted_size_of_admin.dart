import 'package:flutter/material.dart';

import '../text_style.dart';

class SeletedSizeOfAdmin extends StatelessWidget {
  const SeletedSizeOfAdmin({
    super.key,
    required this.sizeList,
    required this.selectedSize, required this.onTapSeletedSize,
  });

  final List<String> sizeList;
  final List<String> selectedSize;
  final Function(String) onTapSeletedSize;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: sizeList.map((size) {
        bool isSelected = false;
        if (selectedSize.contains(size)) {
          isSelected = true;
        }
        return GestureDetector(
          onTap: () {
            onTapSeletedSize(size);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Text(
                size,
                style: textStyleApp(
                  FontWeight.normal,
                  isSelected ? Colors.white : Colors.black,
                  18,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
