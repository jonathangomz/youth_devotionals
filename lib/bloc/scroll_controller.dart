import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollCtrl extends GetxController {
  var controller = ScrollController().obs;
  var percentage = 0.0.obs;

  @override
  void onInit() {
    controller.value.addListener(() {
      if (!controller.value.position.outOfRange &&
          controller.value.position.maxScrollExtent > 0) {
        percentage(controller.value.offset /
            controller.value.position.maxScrollExtent);
      }
    });
    super.onInit();
  }
}
