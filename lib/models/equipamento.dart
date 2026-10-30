class Equipamento {
  final int? id;
  final String nome;
  final int unidadeId;
  const Equipamento({this.id, required this.nome, required this.unidadeId});
  factory Equipamento.fromJson(Map<String, dynamic> j) => Equipamento(
    id: (j['Id'] as num?)?.toInt(),
    nome: j['Nome'] as String? ?? '',
    unidadeId: (j['UnidadeId'] as num).toInt(),
  );
  Map<String, dynamic> toJson() => {'Nome': nome, 'UnidadeId': unidadeId};
}
