import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyleApp(FontWeight fontWeight, Color colors, double fontsize){
  return GoogleFonts.poppins(fontWeight: fontWeight, color: colors, fontSize: fontsize);
}

TextStyle textStyleAppHeight(FontWeight fontWeight, Color colors, double fontsize, double height) {
  return GoogleFonts.poppins(
      fontWeight: fontWeight, color: colors, fontSize: fontsize, height: height);
}
