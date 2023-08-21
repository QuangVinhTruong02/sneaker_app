import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Validation {
  final _email = BehaviorSubject<String>.seeded('@');
  final _firstName = BehaviorSubject<String>.seeded('');
  final _lastName = BehaviorSubject<String>.seeded('');
  final _phone = BehaviorSubject<String>.seeded('');
  final _address = BehaviorSubject<String>.seeded('');
  final _password = BehaviorSubject<String>.seeded('');
  final _confirmPassword = BehaviorSubject<String>.seeded('');

  Stream<String> get email => _email.stream.transform(validateEmail);
  Sink<String> get sinkEmail => _email.sink;

  Stream<String> get firstName => _firstName.stream.transform(validateName);
  Sink<String> get sinkFirstName => _firstName.sink;

  Stream<String> get lastName => _lastName.stream.transform(validateName);
  Sink<String> get sinkLastName => _lastName.sink;

  Stream<String> get phone => _phone.stream.transform(validatePhone);
  Sink<String> get sinkPhone => _phone.sink;

  Stream<String> get address => _address.stream.transform(validateAddress);
  Sink<String> get sinkAddress => _address.sink;

  Stream<String> get password => _password.stream.transform(validatePassword);
  Sink<String> get sinkPassword => _password.sink;

  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(validateConfirmPassword);
  Sink<String> get sinkConfirmPassword => _confirmPassword.sink;

  Stream<bool> get submitValid => Rx.combineLatest7(
      email,
      firstName,
      lastName,
      phone,
      address,
      password,
      confirmPassword,
      (email, firstName, lastName, phone, address, password, confirmPassword) =>
          true);

  Stream<bool> get submitEditProfile => Rx.combineLatest4(
      firstName, lastName, phone, address, (a, b, c, d) => true);

  //xác thực email
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length != 1) {
        isEmail(data)
            ? sink.add(data)
            : sink.addError('Vui lòng nhập email hợp lệ!');
      }
    },
  );

  //xác thực tên
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        isName(data) ? sink.add(data) : sink.addError('Vui lòng điền tên vào!');
      }
    },
  );

  //xác thực SĐT
  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        data.length == 10
            ? sink.add(data)
            : sink.addError('Vui lòng điền số điện thoại!');
      }
    },
  );

  //xác thực địa chỉ
  final validateAddress = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        data.length >= 10
            ? sink.add(data)
            : sink.addError('Vui lòng điền địa chỉ!');
      }
    },
  );

  //xacs thực password
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      data.length >= 6
          ? sink.add(data)
          : sink.addError('Mật khẩu tối thiểu 6 chữ số');
    },
  );

  //xác nhận
  final validateConfirmPassword =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      (data.toString() == validation._password.value.toString())
          ? sink.add(data)
          : sink.addError('Mật khẩu không chính xác');
    },
  );
  static bool isEmail(String email) {
    String value =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+_/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(value);
    return regExp.hasMatch(email);
  }

  static bool isName(String name) {
    String value = r"^[a-zA-Z ]+$";
    RegExp regExp = RegExp(value);
    return regExp.hasMatch(name);
  }
}

final validation = Validation();
