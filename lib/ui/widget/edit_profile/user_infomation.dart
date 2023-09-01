import 'package:flutter/material.dart';

import '../../../service/validation.dart';
import '../register_page.dart/valid_form_widget.dart';

class UserInfomation extends StatelessWidget {
  const UserInfomation({
    super.key,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
  })  : _firstNameController = firstNameController,
        _lastNameController = lastNameController,
        _phoneController = phoneController,
        _addressController = addressController;

  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _phoneController;
  final TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Họ tên người dùng: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Số điện thoại: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ValidFormWidget(
                stream: validation.phone,
                controller: _phoneController,
                nameText: 'Phone',
                sink: validation.sinkPhone,
              ),
              const SizedBox(
                height: 15,
              ),
              //address
              const Text(
                "Địa chỉ: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              ValidFormWidget(
                stream: validation.address,
                controller: _addressController,
                nameText: 'Address',
                sink: validation.sinkAddress,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
