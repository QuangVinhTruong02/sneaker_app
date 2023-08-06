import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

TextStyle textStyleApp(FontWeight fontWeight, Color colors, double fontsize) {
  return GoogleFonts.poppins(
      fontWeight: fontWeight, color: colors, fontSize: fontsize);
}

String formaCurrencyText(int value) {
  var f = NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 3);
  return f.format(value).replaceAll(',', '.');
}
