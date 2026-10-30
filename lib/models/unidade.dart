class Unidade {
  final int? id;
  final String nome;
  const Unidade({this.id, required this.nome});
  factory Unidade.fromJson(Map<String, dynamic> j) =>
      Unidade(id: (j['Id'] as num?)?.toInt(), nome: j['Nome'] as String? ?? '');
  Map<String, dynamic> toJson() => {'Nome': nome};
}
