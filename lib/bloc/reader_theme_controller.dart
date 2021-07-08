import 'package:get/get.dart';

class ThemeReaderController extends GetxController {
  static const double minFontSize = 16.0;
  static const double maxFontSize = 24.0;

  double scale = 1.0;

  var fontSize = 18.0.obs;

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
