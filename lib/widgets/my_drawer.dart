import 'package:fakestore_explorer/login/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:fakestore_explorer/login/controllers/login_page_controller.dart';
import 'package:fakestore_explorer/products/pages/favorite_products_list.dart';
import 'package:fakestore_explorer/products/pages/product_list.dart';
import 'package:fakestore_explorer/utils/constants.dart';
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
              // Obtém o email do usuário autenticado
              AuthController().firebaseUser.value?.email ?? 'User Email',
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
              // Fechar o Drawer
              Navigator.pop(context);
              if (Get.currentRoute == ProductList.routeName) {
                // Apenas fecha o Drawer e não faz nada mais.
                return;
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
              // Fechar o Drawer
              Navigator.pop(context);
              if (Get.currentRoute == FavoriteProductsList.routeName) {
                // Apenas fecha o Drawer e não faz nada mais.
                return;
              }
              Get.to(() => FavoriteProductsList());
            },
          ),
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
              // Realiza o logout
              await Get.find<LoginPageController>().logout();
            },
          ),
        ],
      ),
    );
  }
}