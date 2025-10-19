import 'package:flutter/material.dart';
import 'package:fakestore_explorer/products/models/product_model.dart';
import 'package:fakestore_explorer/services/api_service_impl.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final searchController = TextEditingController();
  final categoryController = TextEditingController();

  RxList<Product>? products = <Product>[].obs;
  RxList<Product>? filteredProducts = <Product>[].obs;

  Future<List<Product>?> findAll() async {
    // Busca todos os produtos da API
    final result = await ApiServiceImpl().get('/products');
    // Caso a resposta seja nula, retorna uma lista vazia
    if (result == null) return [];
    // Caso a resposta não seja nula, converte os dados para uma lista de produtos
    List<Product>? response = (result as List).map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    // Atualiza a lista de produtos e a lista de produtos filtrados
    products?.value = response;
    filteredProducts?.value = products ?? [];
    // Retorna a lista de produtos
    return products;
  }

  Future<void> filterProducts() async {
    // Filtra os produtos com base no texto de busca
    // Se o campo de busca estiver vazio, retorna todos os produtos
    if (searchController.text.isEmpty) {
      filteredProducts?.value = products!;
    }
    // Filtra os produtos cujo título contém o texto de busca (case insensitive)
    // Na hora da busca dos dados, utiliza o toLowerCase para evitar problemas com maiúsculas e minúsculas
    filteredProducts?.value = products?.where((product) => product.title!.toLowerCase().contains(searchController.text.toLowerCase())).toList() ?? [];
  }

  Future<void> filterProductsByCategory() async {
    // Filtra os produtos com base na categoria
    // Se o campo de categoria estiver vazio, retorna todos os produtos
    if (categoryController.text.isEmpty) {
      filteredProducts?.value = products!;
    }
    // Filtra os produtos cuja categoria contém o texto de busca (case insensitive)
    // Na hora da busca dos dados, utiliza o toLowerCase para evitar problemas com mai
    filteredProducts?.value = products?.where((product) => product.category!.toLowerCase().contains(categoryController.text.toLowerCase())).toList() ?? [];
  }

}