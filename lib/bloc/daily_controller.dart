import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:young_devotionals/api/daily.dart';
import 'package:young_devotionals/models/devotional.dart';

class DailyController extends GetxController {
  var devotional = Devotional.empty().obs;
  var isLoading = false.obs;
  var haveError = false.obs;

  var _tmpDevotional;

  @override
  void onInit() {
    isLoading(true);
    fetchDailyDevotional()
        .then((value) => devotional(value ?? Devotional.empty()))
        .catchError((_) {
      haveError(true);
    }).then((_) => isLoading(false));
    super.onInit();
  }

  void refreshDailyDevotional() {
    isLoading(true);
    haveError(false);

    // Save current devotional on memory
    _tmpDevotional =
        this.devotional.value.title.isNotEmpty ? this.devotional.value : null;

    // Reset current devotional to clean the screen
    devotional(Devotional.empty());

    fetchDailyDevotional().then((value) {
      if (value == null) {
        Get.snackbar('Error', 'Ocurrió un error',
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ),
            margin: EdgeInsets.zero);
      }
      // If cannot retrieve the daily devotional then try to let the current loaded devotional
      devotional(value ?? _tmpDevotional ?? Devotional.empty());
    }).catchError((_) {
      devotional(_tmpDevotional ?? Devotional.empty());
      haveError(true);
    }).then((_) => isLoading(false));
  }
}
