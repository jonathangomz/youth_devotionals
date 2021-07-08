import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadController extends GetxController {
  var controller = ScrollController().obs;
  var percentage = 0.0.obs;
  var getToBottom = false;

  @override
  void onInit() {
    controller.value.addListener(() {
      if (!controller.value.position.outOfRange &&
          controller.value.position.maxScrollExtent > 0) {
        percentage(controller.value.offset /
            controller.value.position.maxScrollExtent);
      }
    });

    this.percentage.listen((v) {
      if (v >= 0.99 && !getToBottom) {
        getToBottom = true;
        Get.snackbar(
          'Listo!',
          'Has leído todo el devocional de hoy 😃',
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.done,
            color: Colors.green,
          ),
        );
      }
    });

    super.onInit();
  }
}
