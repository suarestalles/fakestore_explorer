import 'package:flutter/material.dart';
import 'package:fakestore_explorer/utils/my_colors.dart';

// Tema Claro (Light Theme)
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey[100],
  cardTheme: CardThemeData(
    color: primaryColor
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(Colors.white),
    trackColor: WidgetStatePropertyAll(toggleTrackColor)
  ),
  iconTheme: IconThemeData(
    color: iconColor,
  )
  // Adicione outras configurações de tema claro aqui
);

// Tema Escuro (Dark Theme)
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  cardTheme: CardThemeData(
    color: primaryColorDark
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(Colors.blueAccent),
    trackColor: WidgetStatePropertyAll(primaryColor)
  ),
  iconTheme: IconThemeData(
    color: iconColorDark,
  )
  // Adicione outras configurações de tema escuro aqui
);