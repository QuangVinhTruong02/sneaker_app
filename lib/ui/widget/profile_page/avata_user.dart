import 'package:flutter/material.dart';

class AvataUser extends StatelessWidget {
  const AvataUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        child: CircleAvatar(
          radius: 55.0,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50.0,
            backgroundImage: AssetImage('assets/images/profile.png'),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12.0,
                child: Icon(
                  Icons.camera_alt,
                  size: 15.0,
                  color: Color(0xFF404040),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
