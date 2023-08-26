import 'dart:io';

import 'package:flutter/material.dart';

class AvataUser extends StatelessWidget {
  final bool checkPage;
  final String? imageLocal;
  final String? imageUrl;
  final VoidCallback? onTap;
  const AvataUser({
    super.key,
    this.imageUrl,
    this.imageLocal,
    required this.checkPage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return checkPage == true ? _editProfile() : _profilePage();
  }

  Widget _editProfile() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        child: CircleAvatar(
          radius: 55.0,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50.0,
            backgroundImage: (imageLocal == null || imageLocal == "")
                ? NetworkImage(imageUrl!) as ImageProvider
                : FileImage(File(imageLocal!)),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15.0,
                child: IconButton(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 15.0,
                    color: Color(0xFF404040),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profilePage() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        child: CircleAvatar(
          radius: 55.0,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50.0,
            backgroundImage: NetworkImage(imageUrl!),
          ),
        ),
      ),
    );
  }
}
