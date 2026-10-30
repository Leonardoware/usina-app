class UnidadeMedida {
  final int? id;
  final String nome;
  final String simbolo;
  const UnidadeMedida({this.id, required this.nome, required this.simbolo});
  factory UnidadeMedida.fromJson(Map<String, dynamic> j) => UnidadeMedida(
    id: (j['Id'] as num?)?.toInt(),
    nome: j['Nome'] as String? ?? '',
    simbolo: j['Simbolo'] as String? ?? '',
  );
  Map<String, dynamic> toJson() => {'Nome': nome, 'Simbolo': simbolo};
}
