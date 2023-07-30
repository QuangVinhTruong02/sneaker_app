import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/main_screen_notifier.dart';
import 'package:sneaker_app/service/firestore_service.dart';
import 'package:sneaker_app/ui/view/check_page.dart';
import 'package:sneaker_app/ui/view/home_page.dart';
import 'package:sneaker_app/ui/view/search_page.dart';

import '../widget/main_screen/bottom_navigation.dart';
import 'cart_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList = [
    HomePage(),
    SearchPage(),
    CartPage(),
    CheckPage(),
  ];

  @override
  void initState() {
    FirestoreService().getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          // backgroundColor: Colors.black,
          body: pageList[mainScreenNotifier.position],
          bottomNavigationBar: BottomNavigation(),
        );
      },
    );
  }
}
