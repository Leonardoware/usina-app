class Indicador {
    final int? id;
    final String nome;
    final String descricao;
    final String url;

Indicador({
    this.id,
    required this.nome,
    required this.descricao,
    required this.url,
  });
}
class Temperatura{
  final int id;
  final String nome;
  final double valor;
  final String unidade;
  final DateTime data;

  Temperatura({
    required this.id,
    required this.nome,
    required this.valor,
    required this.unidade,
    required this.data,
  });
}

class Umidade{
  final int id;
  final String nome;
  final double valor;
  final String unidade;
  final DateTime data;

  Umidade({
    required this.id,
    required this.nome,
    required this.valor,
    required this.unidade,
    required this.data,
  });
}
  