// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "you_have_pushed_the_button_this_many_times": "You have pushed the button this many times:"
};
static const Map<String,dynamic> ru = {
  "you_have_pushed_the_button_this_many_times": "Вы нажали кнопку раз:"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
