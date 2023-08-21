import 'package:flutter/material.dart';
import 'package:sneaker_app/controller/profile_notifier.dart';
import 'package:sneaker_app/service/auth_service.dart';

import '../text_style.dart';

class ProfileFunction extends StatelessWidget {
  final int value;
  const ProfileFunction({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(1, 2),
              color: Colors.grey),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: GestureDetector(
          onTap: () {
            switch (value) {
              case 1:
                break;
              case 2:
                break;
              case 3:
                AuthService().SignOut();
                break;
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(ProfileNotifier().getIcon(value)),
                  SizedBox(width: 10),
                  Text(
                    ProfileNotifier().getPosition(value),
                    style: textStyleApp(
                      FontWeight.normal,
                      value == 3 ? Colors.red : Colors.black,
                      20,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
