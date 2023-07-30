import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/controller/main_screen_notifier.dart';
import 'package:sneaker_app/service/auth_service.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    int id = 0;
    Future getId() async {
      await FirebaseFirestore.instance
          .collection('users')
          .orderBy('sendTime', descending: true)
          .limit(1)
          .get()
          .then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.docs.first.id)));
        id = int.parse(value.docs.first.id);
      });
    }

    Future SignOut() async {
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
        body: FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final b = snapshot.data!.docs.first.reference.id;

          return Column(
            children: [
              Text(id.toString()),
              Text(b.toString()),
              Text("${FirebaseAuth.instance.currentUser!.email.toString()}"),
              ElevatedButton(
                onPressed: () {
                  Provider.of<MainScreenNotifier>(context, listen: false)
                      .position = 0;
                  AuthService().SignOut();
                },
                child: Text('sign out'),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
