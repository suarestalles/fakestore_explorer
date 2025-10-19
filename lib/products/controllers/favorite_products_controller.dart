import 'package:flutter/material.dart';
import 'package:fakestore_explorer/main.dart';
import 'package:fakestore_explorer/products/models/product_model.dart';
import 'package:get/get.dart';

class FavoriteProductsListController extends GetxController {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final searchController = TextEditingController();
  final categoryController = TextEditingController();

  RxList<Product>? products = <Product>[].obs;
  RxList<Product>? filteredProducts = <Product>[].obs;

  // Busca todos os produtos favoritos armazenados localmente
  Future<List<Product>?> findAll() async {
    final productBox = objectbox.store.box<Product>();
    final result = await productBox.getAllAsync().then((value) => value);
    // Caso não tenha produtos favoritos, limpa a lista
    if (result.isEmpty) {
      products?.clear();
    } else {
      // Caso tenha produtos favoritos, atualiza a lista
      products?.value = result;
    }
    // Atualiza a lista de produtos filtrados
    filteredProducts?.value = products ?? [];
    return products;
  }

  Future<void> filterProducts() async {
    // Filtra os produtos com base no texto de busca
    // Se o campo de busca estiver vazio, retorna os produtos favoritos
    if (searchController.text.isEmpty) {
      filteredProducts?.value = products!;
    }
    // Filtra os produtos cujo título contém o texto de busca (case insensitive)
    // Na hora da busca dos dados localmente, utiliza o toLowerCase para evitar problemas com maiúsculas e minúsculas
    filteredProducts?.value = products?.where((product) => product.title!.toLowerCase().contains(searchController.text.toLowerCase())).toList() ?? [];
  }

  Future<void> filterProductsByCategory() async {
    // Filtra os produtos com base na categoria
    // Se o campo de categoria estiver vazio, retorna os produtos favoritos
    if (categoryController.text.isEmpty) {
      filteredProducts?.value = products!;
    }
    // Filtra os produtos cuja categoria contém o texto de busca (case insensitive)
    // Na hora da busca dos dados localmente, utiliza o toLowerCase para evitar problemas com maiúsculas e minúsculas
    filteredProducts?.value = products?.where((product) => product.category!.toLowerCase().contains(categoryController.text.toLowerCase())).toList() ?? [];
  }

}