import 'package:flutter/material.dart';

class ItemOfBottom extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function()? onTap;
  const ItemOfBottom({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Icon(
          size: 25,
          icon,
          color: color,
        ),
      ),
    );
  }
}
