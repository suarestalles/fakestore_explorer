import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Utilitário para exibir Snackbars personalizadas
class MySnackbars {

  // Snackbar de sucesso
  static SnackbarController successSnackBar(String message) {
    return Get.snackbar(
      'Success',
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM
    );
  }

  // Snackbar de erro
  static SnackbarController errorSnackBar(String message) {
    return Get.snackbar(
      'Error',
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM
    );
  }

  // Snackbar de aviso
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