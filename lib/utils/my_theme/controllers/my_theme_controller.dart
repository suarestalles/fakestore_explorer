import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controlador para gerenciar o tema do aplicativo
class MyThemeController extends GetxController {

  // Variável observável para indicar se o modo escuro está ativado
  var isDarkMode = false.obs;

  // Obtém o tema atual com base no valor de isDarkMode
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // Alterna entre o modo claro e o modo escuro
  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(theme);
  }

}