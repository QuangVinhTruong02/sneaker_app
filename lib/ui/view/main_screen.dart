import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/main_screen_notifier.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/view/profile_page.dart';
import 'package:sneaker_app/ui/view/home_page.dart';

import '../widget/main_screen/bottom_navigation.dart';
import 'cart_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList = [
    const HomePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    FirestoreUser().getCurrentUser();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)  {
      Provider.of<MainScreenNotifier>(context, listen: false).position = 0;
     
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        
        return Scaffold(
          resizeToAvoidBottomInset: true,
          // backgroundColor: Colors.black,
          body: pageList[mainScreenNotifier.position],
          bottomNavigationBar: const BottomNavigation(),
        );
      },
    );
  }
}
