import 'dart:convert';
import 'package:fakestore_explorer/services/api_service.dart';
import 'package:fakestore_explorer/utils/my_snackbars.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl extends ApiService {

  ApiServiceImpl();
  // Base URL da API FakeStore
  final String baseUrl = 'https://fakestoreapi.com';

  @override
  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      // Se a resposta for bem-sucedida, decodifica o corpo da resposta JSON
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Caso contrário, exibe uma notificação de erro e lança uma exceção
        MySnackbars.errorSnackBar(response.body);
        throw Exception('Erro ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer requisição GET: $e');
    }
  }

  @override
  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      // Se a resposta for bem-sucedida (códigos 200 ou 201), decodifica o corpo da resposta JSON
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // Caso contrário, exibe uma notificação de erro e lança uma exceção
        MySnackbars.errorSnackBar(response.body);
        throw Exception('Erro ao enviar dados: ${response.statusCode}');
      }
    } catch (e) {
      // Em caso de erro na requisição, exibe uma notificação de erro
      MySnackbars.errorSnackBar(e.toString());
      throw Exception('Erro ao fazer requisição POST: $e');
    }
  }

  @override
  Future<dynamic> put(String url, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl + url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      // Se a resposta for bem-sucedida, decodifica o corpo da resposta JSON
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Caso contrário, lança uma exceção
        throw Exception('Erro ao atualizar dados: ${response.statusCode}');
      }
    } catch (e) {
      // Em caso de erro na requisição, lança uma exceção
      throw Exception('Erro ao fazer requisição PUT: $e');
    }
  }

  @override
  Future<dynamic> delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(baseUrl + url));
      // Se a resposta for bem-sucedida, decodifica o corpo da resposta JSON
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Caso contrário, lança uma exceção
        throw Exception('Erro ao excluir dados: ${response.statusCode}');
      }
    } catch (e) {
      // Em caso de erro na requisição, lança uma exceção
      throw Exception('Erro ao fazer requisição DELETE: $e');
    }
  }
}
