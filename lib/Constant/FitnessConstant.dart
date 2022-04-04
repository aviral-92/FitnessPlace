import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FitnessConstant {
  static Color appBarColor = Colors.deepPurple[900];
  static const String CONTENT_TYPE = 'content-type';
  static const String APPLICATION_JSON = 'application/json';
  static DateFormat dateFormat = new DateFormat('MMM-dd-yyyy');
  static DateFormat df = new DateFormat('yyyy-MM-dd');
  static DateFormat dfz = new DateFormat('hh:mm a');
  static const IPHONE_LOCAL_URL = 'http://localhost';
  static const ANDROID_LOCAL_URL = 'http://10.0.2.2';
  // static String BASE_PATH = Platform.isIOS ? '$IPHONE_LOCAL_URL:9092' : '$ANDROID_LOCAL_URL:9092';
  static const String BASE_PATH = 'http://198.12.225.231:9092';

  static TextStyle ryeGoogleFont() {
    return GoogleFonts.rye(
      color: Colors.black.withOpacity(1),
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle leckerliOneGoogleFont() {
    return GoogleFonts.leckerliOne(
      color: Colors.deepPurple[900].withOpacity(1),
      fontSize: 30.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle macondoGoogleFont() {
    return GoogleFonts.macondo(
      color: Colors.black.withOpacity(1),
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle tauriGoogleFont() {
    return GoogleFonts.tauri(
      color: Colors.black.withOpacity(0.7),
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle tauriGoogleFontSize() {
    return GoogleFonts.tauri(
      color: Colors.black.withOpacity(1),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );
  }
}
