import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usina_app/services/config/api_config.dart';

class ApiService<T> {
  final String endpoint;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  const ApiService({
    required this.endpoint,
    required this.fromJson,
    required this.toJson,
  });
  Uri _uri([int? id]) =>
      Uri.parse('${ApiConfig.baseUrl}$endpoint${id == null ? '' : '/$id'}');
  void _check(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  Future<List<T>> listar() async {
    final response = await http.get(_uri());
    _check(response);
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! List) {
      throw const FormatException('A API deve retornar uma lista JSON no GET.');
    }
    return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<T> buscar(int id) async {
    final response = await http.get(_uri(id));
    _check(response);
    return fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
    );
  }

  Future<void> criar(T item) async {
    final response = await http.post(
      _uri(),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(toJson(item)),
    );
    _check(response);
  }

  Future<void> atualizar(int id, T item) async {
    final response = await http.put(
      _uri(id),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(toJson(item)),
    );
    _check(response);
  }

  Future<void> excluir(int id) async {
    final response = await http.delete(_uri(id));
    _check(response);
  }
}
