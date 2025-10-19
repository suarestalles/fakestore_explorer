import 'package:fakestore_explorer/utils/my_theme/controllers/my_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyToggleTheme extends StatefulWidget {
  const MyToggleTheme({super.key});

  @override
  State<MyToggleTheme> createState() => _MyToggleThemeState();
}

class _MyToggleThemeState extends State<MyToggleTheme> {
  @override
  Widget build(BuildContext context) {
    final MyThemeController themeController = Get.find();
    return Row(
      children: [
        // Ícone do sol para o modo claro
        Icon(
          Icons.sunny,
          color: Colors.amber
        ),
        // Switch para alternar entre os temas
        Obx(
          () => Switch(value: themeController.isDarkMode.value, onChanged: themeController.toggleTheme),
        ),
        // Ícone da lua para o modo escuro
        Icon(
          Icons.nightlight_round_sharp,
          color: Colors.white,
        ),
      ],
    );
  }
}