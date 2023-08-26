import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sneaker_app/models/user_data.dart';
import 'package:sneaker_app/service/firestore_service/firestore_user/firestore_user.dart';
import 'package:sneaker_app/ui/widget/profile_page/avata_user.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

import '../../service/validation.dart';
import '../widget/register_page.dart/valid_form_widget.dart';

class EditProfile extends StatefulWidget {
  final UserData user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    validation.sinkFirstName.add(widget.user.firstName);
    validation.sinkLastName.add(widget.user.lastName);
    validation.sinkPhone.add(widget.user.phone);
    validation.sinkAddress.add(widget.user.address);

    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _phoneController.text = widget.user.phone;
    _addressController.text = widget.user.address;
    super.initState();
  }

  bool checkForm() {
    if (_firstNameController.text != '' &&
        _firstNameController.text != widget.user.firstName) {
      return true;
    }
    if (_lastNameController.text != '' &&
        _lastNameController.text != widget.user.lastName) {
      return true;
    }
    if (_phoneController.text != '' &&
        _phoneController.text != widget.user.phone) {
      return true;
    }
    if (_addressController.text != '' &&
        _addressController.text != widget.user.address) {
      return true;
    }
    return false;
  }

  String image = "";
  void onTap() async {
    ImagePicker imagePicker = new ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    // print("path: ${file?.path}");

    if (file == null) return;

    image = file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset("assets/images/top_image.png"),
              Positioned(
                top: 15,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Edit Profile",
                            textAlign: TextAlign.center,
                            style: textStyleApp(
                              FontWeight.bold,
                              Colors.white,
                              26,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: validation.submitEditProfile,
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onTap: (snapshot.data == true && checkForm()) ||
                                    image != ""
                                ? () async {
                                    if (image != "") {
                                      Reference referenceRoot =
                                          FirebaseStorage.instance.ref();
                                      Reference referenceDirImages =
                                          referenceRoot
                                              .child(FirestoreUser.email);
                                      Reference referenceImageToUpload =
                                          referenceDirImages.child("avatar");
                                      try {
                                        await referenceImageToUpload
                                            .putFile(File(image));
                                        image = await referenceImageToUpload
                                            .getDownloadURL();
                                        widget.user.avatar = image;
                                        print("image: ${image}");
                                      } catch (e) {
                                        e.toString();
                                      }
                                    }

                                    widget.user.firstName =
                                        _firstNameController.text;
                                    widget.user.lastName =
                                        _lastNameController.text;
                                    widget.user.phone = _phoneController.text;
                                    widget.user.address =
                                        _addressController.text;

                                    FirestoreUser()
                                        .updateDetailUser(widget.user, context);
                                  }
                                : () {},
                            child: Text(
                              "Update",
                              style: (snapshot.data == true && checkForm()) ||
                                      image != ""
                                  ? textStyleApp(
                                      FontWeight.bold,
                                      Colors.white,
                                      18,
                                    )
                                  : textStyleApp(
                                      FontWeight.bold,
                                      Colors.grey,
                                      18,
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 48),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.09,
                      left: 8,
                      right: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            //first name
                            Flexible(
                              flex: 1,
                              child: ValidFormWidget(
                                stream: validation.firstName,
                                controller: _firstNameController,
                                nameText: 'First Name',
                                sink: validation.sinkFirstName,
                              ),
                            ),
                            const SizedBox(width: 15),
                            //last name
                            Flexible(
                              flex: 1,
                              child: ValidFormWidget(
                                stream: validation.lastName,
                                controller: _lastNameController,
                                nameText: 'Last Name',
                                sink: validation.sinkLastName,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        ValidFormWidget(
                          stream: validation.phone,
                          controller: _phoneController,
                          nameText: 'Phone',
                          sink: validation.sinkPhone,
                        ),
                        //address
                        const SizedBox(height: 15),
                        ValidFormWidget(
                          stream: validation.address,
                          controller: _addressController,
                          nameText: 'Address',
                          sink: validation.sinkAddress,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: AvataUser(
                  imageUrl: widget.user.avatar,
                  imageLocal: image,
                  checkPage: true,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
