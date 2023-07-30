import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service.dart';
import '../text_style.dart';

class ButtonSignUp extends StatelessWidget {
  const ButtonSignUp({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
        ),
        onPressed: () {
          Provider.of<AuthService>(context, listen: false).SignIn(
            context,
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
        },
        child: Text(
          'Đăng nhập',
          style: textStyleApp(FontWeight.bold, Colors.white, 16),
        ),
      ),
    );
  }
}
