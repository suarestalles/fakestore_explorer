import 'package:fakestore_explorer/widgets/my_toggle_theme.dart';
import 'package:flutter/material.dart';
import 'package:fakestore_explorer/products/controllers/favorite_products_controller.dart';
import 'package:fakestore_explorer/products/widgets/product_list_card.dart';
import 'package:fakestore_explorer/utils/constants.dart';
import 'package:fakestore_explorer/widgets/my_drawer.dart';
import 'package:fakestore_explorer/widgets/my_text_form_field.dart';
import 'package:get/get.dart';

class FavoriteProductsList extends StatefulWidget {

  static const routeName = '/favorite_products';

  const FavoriteProductsList({super.key});

  @override
  State<FavoriteProductsList> createState() => _FavoriteProductsListState();
}

class _FavoriteProductsListState extends State<FavoriteProductsList> {
  
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FavoriteProductsListController());
    return Material(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          actionsPadding: EdgeInsets.all(defaultPadding),
          actions: [MyToggleTheme()],
        ),
        drawer: MyDrawer(),
        body: GetBuilder(
          init: Get.find<FavoriteProductsListController>(),
          builder: (controller) {
            return FutureBuilder(
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
            );
          },
        ),
      ),
    );
  }
}