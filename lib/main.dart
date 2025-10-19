import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:franq_store/firebase_options.dart';
import 'package:franq_store/login/controllers/auth_controller.dart';
import 'package:franq_store/login/controllers/login_page_controller.dart';
import 'package:franq_store/login/pages/login_page.dart';
import 'package:franq_store/objectbox.dart';
import 'package:franq_store/products/pages/favorite_products_list.dart';
import 'package:franq_store/products/pages/product_list.dart';
import 'package:franq_store/utils/my_theme/controllers/my_theme_controller.dart';
import 'package:franq_store/utils/my_themes.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ObjectBox.deleteObjectBoxDb();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  objectbox = await ObjectBox.create();
  runApp(MyApp(storage: CounterStorage()));

}

class MyApp extends StatelessWidget {
  final CounterStorage storage;
  final MyThemeController themeController = Get.put(MyThemeController());
  MyApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginPageController());
    Get.lazyPut(() => MyThemeController());
    Get.put(AuthController());
    return Obx(
      () => GetMaterialApp(
        title: 'Franq Store',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.theme,
        initialRoute: Get.find<LoginPageController>().isAuthenticated == null ? '/login' : '/products',
        getPages: [
          GetPage(name: '/login', page: () => LoginPage()),
          GetPage(name: '/products', page: () => ProductList()),
          GetPage(name: '/favorite_products', page: () => FavoriteProductsList()),
        ],
        // home: const ProductList(),
      ),
    );
  }
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

}
