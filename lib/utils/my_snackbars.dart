import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackbars {

  static SnackbarController successSnackBar(String message) {
    return Get.snackbar(
      'Success',
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM
    );
  }

  static SnackbarController errorSnackBar(String message) {
    return Get.snackbar(
      'Error',
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM
    );
  }

  static SnackbarController warningSnackBar(String message) {
    return Get.snackbar(
      'Warning',
      message,
      colorText: Colors.black,
      backgroundColor: Colors.amber,
      snackPosition: SnackPosition.BOTTOM
    );
  }

}