import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();
  static const routeName = '/CodegenLoader';
  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "TIT": "فواكه و خضار ",
    "NOAA_FAWAKEH": "فواكه",
    "NOAA_KHODAR": "خضار",
    "l_all":"اللكل"

  };
  static const Map<String, dynamic> en = {
    "TIT": "Fruits and Vegetables",
    "NOAA_FAWAKEH": "Fruits",
    "NOAA_KHODAR": "Vegetables",
    "l_all":"All"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en
  };
}
