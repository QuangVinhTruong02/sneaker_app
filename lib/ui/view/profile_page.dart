import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/models/user_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/view/edit_profile.dart';
import 'package:sneaker_app/ui/widget/profile_page/profile_function.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

import '../widget/profile_page/avata_user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirestoreUser.idUser)
              .snapshots(),
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.active) {
              UserData user = UserData.fromJson(snapshot.data!.data()!);
              
              return  Stack(
                  children: [
                    Image.asset("assets/images/top_image.png"),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        //margin: const EdgeInsets.only(top: 48),
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        //detail
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.07),
                            ),
                            Text(
                              "${user.firstName} ${user.lastName}",
                              style: textStyleApp(
                                FontWeight.bold,
                                Colors.black,
                                25,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              user.email!,
                              style: textStyleApp(
                                FontWeight.normal,
                                Colors.grey,
                                20,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(user: user),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                              ),
                              child: Text(
                                "Chỉnh sửa hồ sơ",
                                style: textStyleApp(
                                  FontWeight.normal,
                                  Colors.white,
                                  16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Column(
                              children: [
                                ProfileFunction(
                                  value: 1,
                                  user: user,
                                ),
                                SizedBox(height: 5),
                                ProfileFunction(value: 2),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 15),
                                ProfileFunction(value: 3),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // avata user
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.08),
                      child: AvataUser(checkPage: false, imageUrl: user.avatar),
                    ),
                  ],
                
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
