import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/cart_notifier.dart';
import 'package:sneaker_app/controller/product_notifier.dart';
import 'package:sneaker_app/service/auth_service.dart';
import 'package:sneaker_app/service/firestore_service/firestore_product.dart';
import 'package:sneaker_app/service/firestore_service/firestore_shop.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_cart.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/controller/main_screen_notifier.dart';

import 'auth/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // await SystemChrome.setSystemUIChangeCallback(
  //   (systemOverlaysAreVisible) async {
  //     if (systemOverlaysAreVisible) {
  //       await Future.delayed(
  //         Duration(seconds: 3),
  //         () {
  //           SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //         },
  //       );
  //     }
  //   },
  // );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreProduct>(create: (context) => FirestoreProduct()),
        Provider<FirestoreUser>(create: (context) => FirestoreUser()),
        Provider<FirestoreShop>(create: (context) => FirestoreShop()),
        Provider<FirestoreCart>(
          create: (context) => FirestoreCart(),
        ),
        ChangeNotifierProvider<MainScreenNotifier>(
          create: (_) => MainScreenNotifier(),
        ),
        ChangeNotifierProvider<ProductNotifier>(
          create: (context) => ProductNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartNotifier(),
        )
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}
