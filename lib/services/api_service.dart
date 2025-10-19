// Definição da interface ApiService
abstract class ApiService {
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, Map<String, dynamic> data);
  Future<dynamic> put(String url, Map<String, dynamic> data);
  Future<dynamic> delete(String url);
}