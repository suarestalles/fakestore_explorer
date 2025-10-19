import 'package:flutter/material.dart';
import 'package:franq_store/products/models/product_model.dart';
import 'package:franq_store/services/api_service_impl.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final searchController = TextEditingController();
  final categoryController = TextEditingController();

  RxList<Product>? products = <Product>[].obs;
  RxList<Product>? filteredProducts = <Product>[].obs;

  Future<List<Product>?> findAll() async {
    final result = await ApiServiceImpl().get('/products');
    if (result == null) return [];
    List<Product>? response = (result as List).map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    products?.value = response;
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