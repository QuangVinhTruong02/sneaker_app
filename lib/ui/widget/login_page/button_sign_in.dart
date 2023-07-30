import 'package:flutter/material.dart';

import '../../view/register_page.dart';
import '../text_style.dart';

class ButtonSignIn extends StatelessWidget {
  const ButtonSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ));
        },
        child: Text(
          'Đăng ký',
          style: textStyleApp(FontWeight.bold, Colors.blueAccent, 16),
        ),
      ),
    );
  }
}
