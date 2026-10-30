class TipoInformacao {
  final int? id;
  final String nome;
  final int unidadeMedidaId;
  const TipoInformacao({
    this.id,
    required this.nome,
    required this.unidadeMedidaId,
  });
  factory TipoInformacao.fromJson(Map<String, dynamic> j) => TipoInformacao(
    id: (j['Id'] as num?)?.toInt(),
    nome: j['Nome'] as String? ?? '',
    unidadeMedidaId: (j['UnidadeMedidaId'] as num).toInt(),
  );
  Map<String, dynamic> toJson() => {
    'Nome': nome,
    'UnidadeMedidaId': unidadeMedidaId,
  };
}
