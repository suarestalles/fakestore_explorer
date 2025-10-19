import 'dart:convert';
import 'package:franq_store/services/api_service.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl extends ApiService {

  ApiServiceImpl();
  final String baseUrl = 'https://fakestoreapi.com';

  @override
  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erro ao enviar dados: ${response.statusCode}');
      }
    } catch (e) {
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
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erro ao atualizar dados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer requisição PUT: $e');
    }
  }

  @override
  Future<dynamic> delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(baseUrl + url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erro ao excluir dados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer requisição DELETE: $e');
    }
  }
}
