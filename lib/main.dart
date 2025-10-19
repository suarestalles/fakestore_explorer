import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fakestore_explorer/firebase_options.dart';
import 'package:fakestore_explorer/login/controllers/auth_controller.dart';
import 'package:fakestore_explorer/login/controllers/login_page_controller.dart';
import 'package:fakestore_explorer/login/pages/login_page.dart';
import 'package:fakestore_explorer/objectbox.dart';
import 'package:fakestore_explorer/products/pages/favorite_products_list.dart';
import 'package:fakestore_explorer/products/pages/product_list.dart';
import 'package:fakestore_explorer/utils/my_theme/controllers/my_theme_controller.dart';
import 'package:fakestore_explorer/utils/my_theme/my_themes.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Para deletar o banco de dados ObjectBox durante o desenvolvimento, descomente a linha abaixo
  // await ObjectBox.deleteObjectBoxDb();
  // Inicializa o Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Inicializa o ObjectBox
  objectbox = await ObjectBox.create();
  // Inicia o aplicativo
  runApp(MyApp(storage: CounterStorage()));

}

class MyApp extends StatelessWidget {
  final CounterStorage? storage;
  final MyThemeController themeController = Get.put(MyThemeController());
  MyApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    // Carrega os controladores necessários
    Get.lazyPut(() => LoginPageController());
    Get.lazyPut(() => MyThemeController());
    Get.put(AuthController());
    // Retorna o aplicativo com suporte a temas claro e escuro
    return Obx(
      () => GetMaterialApp(
        title: 'FakeStore Explorer',
        // Esconde a faixa de debug
        debugShowCheckedModeBanner: false,
        // Define os temas claro e escuro
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.theme,
        // Define as rotas iniciais e páginas
        initialRoute: '/products',
        getPages: [
          GetPage(name: '/login', page: () => LoginPage()),
          GetPage(name: '/products', page: () => ProductList()),
          GetPage(name: '/favorite_products', page: () => FavoriteProductsList()),
        ],
      ),
    );
  }
}

// Classe para armazenar o contador em um arquivo local
class CounterStorage {
  // Obtém o caminho do diretório local do aplicativo
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Obtém o arquivo local onde o contador será armazenado
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  // Lê o valor do contador do arquivo local
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

  // Escreve o valor do contador no arquivo local
  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

}
