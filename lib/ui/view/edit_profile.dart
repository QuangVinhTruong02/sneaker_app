import 'package:flutter/material.dart';
import 'package:sneaker_app/models/user_data.dart';
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
  void initState() {
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _phoneController.text = widget.user.phone;
    _addressController.text = widget.user.address;
    super.initState();
  }

  bool checkForm() {
    List<bool> checks = List.empty(growable: true);
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
                left: 15,
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: IconButton(
                              color: snapshot.hasData == true && checkForm()
                                  ? Colors.blue
                                  : Colors.grey,
                              icon: Icon(Icons.check),
                              onPressed: snapshot.hasData == true && checkForm()
                                  ? () {
                                      // Provider.of<AuthService>(context,
                                      //         listen: false)
                                      //     .SignUp(
                                      //   _emailController.text.trim(),
                                      //   _passwordController.text.trim(),
                                      //   _firstNameController.text.trim(),
                                      //   _lastNameController.text.trim(),
                                      //   _phoneController.text.trim(),
                                      //   _addressController.text.trim(),
                                      //   context,
                                      // );
                                      print("okk");
                                    }
                                  : () {},
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
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: AvataUser(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
