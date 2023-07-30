import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
import '../widget/text_style.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ],
                ),
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
                Text(
                  'Quên mật khẩu',
                  style: textStyleApp(FontWeight.bold, Colors.black, 42),
                ),
                SizedBox(height: 15),
                Text(
                  'Vui lòng nhập địa chỉ email để lấy lại mật khẩu: ',
                  style: textStyleApp(FontWeight.w500, Colors.black, 16),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Vui lòng nhập địa chỉ email",
                    focusColor: Colors.black,
                  ),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  onPressed: () {
                    Provider.of<AuthService>(context, listen: false)
                        .ForgotPassword(_emailController.text.trim(), context);
                  },
                  child: Text(
                    'Gửi',
                    style: textStyleApp(FontWeight.bold, Colors.white, 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
