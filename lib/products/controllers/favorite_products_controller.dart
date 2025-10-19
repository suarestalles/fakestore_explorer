import 'package:flutter/material.dart';
import 'package:franq_store/main.dart';
import 'package:franq_store/products/models/product_model.dart';
import 'package:get/get.dart';

class FavoriteProductsListController extends GetxController {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final searchController = TextEditingController();
  final categoryController = TextEditingController();

  RxList<Product>? products = <Product>[].obs;
  RxList<Product>? filteredProducts = <Product>[].obs;

  Future<List<Product>?> findAll() async {
    final productBox = objectbox.store.box<Product>();
    final result = await productBox.getAllAsync().then((value) => value);
    if (result.isEmpty) {
      products?.clear();
    } else {
      products?.value = result;
    }
    filteredProducts?.value = products ?? [];
    return products;
  }

  Future<void> filterProducts() async {
    if (searchController.text.isEmpty) {
      filteredProducts?.value = products!;
    }
    filteredProducts?.value = products?.where((product) => product.title!.toLowerCase().contains(searchController.text.toLowerCase())).toList() ?? [];
  }

  Future<void> filterProductsByCategory() async {
    if (categoryController.text.isEmpty) {
      filteredProducts?.value = products!;
    }
    filteredProducts?.value = products?.where((product) => product.category!.toLowerCase().contains(categoryController.text.toLowerCase())).toList() ?? [];
  }

}