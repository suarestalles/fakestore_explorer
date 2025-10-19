import 'package:fakestore_explorer/widgets/my_toggle_theme.dart';
import 'package:flutter/material.dart';
import 'package:fakestore_explorer/main.dart';
import 'package:fakestore_explorer/products/controllers/favorite_products_controller.dart';
import 'package:fakestore_explorer/products/controllers/product_list_controller.dart';
import 'package:fakestore_explorer/products/models/product_model.dart';
import 'package:fakestore_explorer/products/pages/favorite_products_list.dart';
import 'package:fakestore_explorer/products/widgets/product_list_card.dart';
import 'package:fakestore_explorer/utils/constants.dart';
import 'package:fakestore_explorer/widgets/my_drawer.dart';
import 'package:fakestore_explorer/widgets/my_text_form_field.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {

  static const routeName = '/products';

  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductListController());
    Get.lazyPut(() => FavoriteProductsListController());
    return Material(
      color: Colors.white,
      child: GetBuilder(
        init: Get.find<ProductListController>(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Stack(
                  alignment: AlignmentGeometry.topRight,
                  children: [
                    IconButton(
                      onPressed: () => Get.to(() => FavoriteProductsList()),
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(50, 0, 0, 0),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(
                        objectbox.store.box<Product>().getAll().length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )
                    ),
                  ],
                ),
                SizedBox(width: defaultPadding),
                MyToggleTheme(),
              ],
              actionsPadding: EdgeInsets.all(defaultPadding),
            ),
            drawer: MyDrawer(),
            body: FutureBuilder(
              future: controller.findAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            spacing: defaultPadding,
                            children: [
                              Text(
                                'Product List',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              MyTextFormField(
                                controller.searchController,
                                controller.filterProducts,
                                'Search by name...',
                                Icons.search,
                              ),
                              MyTextFormField(
                                controller.categoryController,
                                controller.filterProductsByCategory,
                                'Search by category...',
                                Icons.search,
                              ),
                              Obx(
                                () => Column(
                                  children: controller.filteredProducts?.map((product) => ProductListCard(product)).toList() ?? [],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('No products found!'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          );
        }
      ),
    );
  }
}