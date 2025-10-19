import 'package:flutter/material.dart';
import 'package:franq_store/login/controllers/login_page_controller.dart';
import 'package:franq_store/products/pages/favorite_products_list.dart';
import 'package:franq_store/products/pages/product_list.dart';
import 'package:franq_store/utils/constants.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginPageController());
    return Drawer(
      child: ListView(
        children: <Widget>[
        // Cabeçalho do Drawer
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage('https://img.odcdn.com.br/wp-content/uploads/2021/05/Franq-Openbank.png'))
            ),
            child: Text(
              Get.find<LoginPageController>().userEmail,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Itens do menu
          ListTile(
            title: Row(
              spacing: defaultPadding,
              children: [
                Icon(Icons.dashboard),
                Text('Product List'),
              ], 
            ),
            onTap: () {
              Navigator.pop(context);
              if (Get.currentRoute == ProductList.routeName) {
                // print('Já estamos na tela de listagem. Não há navegação.');
                return; // Apenas fecha o Drawer e não faz nada mais.
              }
              Get.off(() => ProductList());
            },
          ),
          ListTile(
            title: Row(
              spacing: defaultPadding,
              children: [
                Icon(Icons.favorite_sharp),
                Text('Favorites'),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              if (Get.currentRoute == FavoriteProductsList.routeName) {
                // print('Já estamos na tela de listagem. Não há navegação.');
                return; // Apenas fecha o Drawer e não faz nada mais.
              }
              Get.to(() => FavoriteProductsList());
            },
          ),
          // Expanded(child: Container()),
          Divider(),
          ListTile(
            title: Row(
              spacing: defaultPadding,
              children: [
                Icon(Icons.exit_to_app),
                Text('Logout'),
              ],
            ),
            onTap: () async {
              // Fechar o Drawer
              Navigator.pop(context);
              // Aqui você pode adicionar a lógica de logout, por exemplo
              // Get.offAll(() => LoginPage());
              await Get.find<LoginPageController>().logout();
            },
          ),
        ],
      ),
    );
  }
}