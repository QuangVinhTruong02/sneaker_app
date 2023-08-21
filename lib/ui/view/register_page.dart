import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/service/validation.dart';
import 'package:sneaker_app/service/auth_service.dart';
import 'package:sneaker_app/ui/widget/register_page.dart/valid_form_widget.dart';

import '../widget/text_style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswrodController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  bool checkForm() {
    if (_emailController.text.trim() != '' &&
        _passwordController.text.trim() != '' &&
        _confirmPasswrodController.text.trim() != '' &&
        _firstNameController.text.trim() != '' &&
        _lastNameController.text.trim() != '' &&
        _phoneController.text.trim() != '' &&
        _addressController.text.trim() != '') {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswrodController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              // text đăng ký
              Text(
                'Đăng ký',
                style: textStyleApp(
                  FontWeight.bold,
                  Colors.black,
                  40,
                ),
              ),

              //email
              const SizedBox(height: 15),
              ValidFormWidget(
                stream: validation.email,
                controller: _emailController,
                nameText: 'Email',
                sink: validation.sinkEmail,
              ),

              //name
              const SizedBox(height: 15),
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

              //phone
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

              //password
              const SizedBox(height: 15),
              ValidFormWidget(
                stream: validation.password,
                controller: _passwordController,
                nameText: 'Password',
                sink: validation.sinkPassword,
              ),

              //confirm password
              const SizedBox(height: 15),
              ValidFormWidget(
                stream: validation.confirmPassword,
                controller: _confirmPasswrodController,
                nameText: 'Confirm password',
                sink: validation.sinkConfirmPassword,
              ),

              const SizedBox(height: 15),

              //Already have an account

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Bạn đã có tài khoản!',
                      style: textStyleApp(FontWeight.bold, Colors.blue, 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              //button signIn
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: validation.submitValid,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        backgroundColor: snapshot.hasData == true && checkForm()
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      onPressed: snapshot.hasData == true && checkForm()
                          ? () {
                              Provider.of<AuthService>(context, listen: false)
                                  .SignUp(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                                _firstNameController.text.trim(),
                                _lastNameController.text.trim(),
                                _phoneController.text.trim(),
                                _addressController.text.trim(),
                                context,
                              );
                            }
                          : () {},
                      child: Text(
                        'Đăng ký',
                        style: textStyleApp(FontWeight.bold, Colors.white, 16),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
