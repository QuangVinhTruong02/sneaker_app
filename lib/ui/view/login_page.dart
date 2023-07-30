import 'package:flutter/material.dart';
import 'package:sneaker_app/ui/view/forgot_password_page.dart';
import 'package:sneaker_app/ui/widget/login_page/textfield_widget.dart';
import 'package:sneaker_app/ui/widget/text_style.dart';

import '../widget/login_page/button_sign_in.dart';
import '../widget/login_page/button_sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/shoes.png',
                    height: 60,
                    width: 60,
                  ),
                  Text(
                    'SNEAKER',
                    style: textStyleApp(FontWeight.bold, Colors.black, 42),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Đăng nhập',
                style: textStyleApp(
                  FontWeight.bold,
                  Colors.black,
                  42,
                ),
                textAlign: TextAlign.center,
              ),

              //email
              const SizedBox(height: 15),

              TextfieldWidget(
                nameText: 'Email',
                controller: _emailController,
              ),

              const SizedBox(height: 15),

              //password
              TextfieldWidget(
                nameText: 'Password',
                controller: _passwordController,
              ),

              const SizedBox(height: 15),

              //forgot password

              Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Quên mật khẩu',
                        style: textStyleApp(FontWeight.bold, Colors.blue, 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              //button signIn
              ButtonSignUp(
                  emailController: _emailController,
                  passwordController: _passwordController),

              const SizedBox(height: 15),
              //button signUp
              ButtonSignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
