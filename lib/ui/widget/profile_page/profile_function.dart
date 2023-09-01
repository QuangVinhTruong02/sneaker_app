import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/controller/profile_notifier.dart';
import 'package:sneaker_app/models/user_data.dart';
import 'package:sneaker_app/service/auth_service.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/view/purchase_history.dart';
import 'package:sneaker_app/ui/view/shop_page.dart';
import 'package:sneaker_app/ui/view/star_selling.dart';

import '../text_style.dart';

class ProfileFunction extends StatelessWidget {
  final UserData? user;
  final int value;
  const ProfileFunction({
    super.key,
    required this.value,
    this.user,
  });
  void _checkShop(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("shops")
        .where("email", isEqualTo: FirestoreUser.email)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StarSelling(
              user: user!,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopPage(),
          ),
        );
      }
    });
  }

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
                _checkShop(context);
                break;
              case 2:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchaseHistory(),
                    ),);
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
