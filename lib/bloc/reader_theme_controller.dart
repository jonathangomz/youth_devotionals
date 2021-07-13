import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeReaderController extends GetxController {
  static const double minFontSize = 16.0;
  static const double maxFontSize = 24.0;

  double scale = 1.0;

  var isLoaded = false.obs;
  var fontSize = 18.0.obs;
  var themeMode = ThemeMode.light.obs;

  bool get isDarkMode => this.themeMode.value == ThemeMode.dark;

  @override
  void onInit() async {
    SharedPreferences.getInstance().then((prefs) {
      bool isDarkMode = prefs.getBool('darkMode') ?? Get.isDarkMode;
      if (isDarkMode) {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
    }).then((_) {
      isLoaded(true);
    });
    super.onInit();
  }

  increaseFont() => updateFontIfValid(this.fontSize.value + scale);

  decreaseFont() => updateFontIfValid(this.fontSize.value - scale);

  updateFontIfValid(double newSize) {
    if (withinRangeFontSize(newSize)) {
      this.fontSize(newSize);
    }
  }

  static bool withinRangeFontSize(double size) =>
      size > minFontSize && size < maxFontSize;
}
