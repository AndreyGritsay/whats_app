import 'package:flutter/material.dart';

abstract class Constants {
  static const String imageWatsApp = 'assets/images/ImageWatsApp.png';
  static const String businessTerms =
      'https://www.whatsapp.com/legal/business-terms/?lang=ru';
  static const String privacyPolicy =
      'https://www.whatsapp.com/legal/updates/privacy-policy/?lang=ru';

  static String assetForFlagImage(String flagName) {
    return 'assets/flags/$flagName.png';
  }

}
