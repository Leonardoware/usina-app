import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config/api_config.dart';

class CrudService {
  final String rota;
  CrudService(this.rota);
  Uri get url => Uri.parse('${ApiConfig.baseUrl}$rota');
  Future<List<Map<String, dynamic>>> listar() async {
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('Erro GET: ${res.statusCode}');
    }
    final dados = jsonDecode(utf8.decode(res.bodyBytes));
    if (dados is! List) throw FormatException('GET deve retornar lista');
    return dados.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> criar(Map<String, dynamic> dados) async {
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dados),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Erro POST: ${res.statusCode}');
    }
  }

  Future<void> editar(int id, Map<String, dynamic> dados) async {
    final res = await http.put(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dados),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Erro PUT: ${res.statusCode}');
    }
  }

  Future<void> excluir(int id) async {
    final res = await http.delete(Uri.parse('$url/$id'));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Erro DELETE: ${res.statusCode}');
    }
  }
}
