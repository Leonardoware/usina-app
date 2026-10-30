class Medicao {
  final int? id;
  final int safraId;
  final int equipamentoId;
  final int tipoInformacaoId;
  final double valor;
  final DateTime data;
  const Medicao({
    this.id,
    required this.safraId,
    required this.equipamentoId,
    required this.tipoInformacaoId,
    required this.valor,
    required this.data,
  });
  factory Medicao.fromJson(Map<String, dynamic> j) => Medicao(
    id: (j['Id'] as num?)?.toInt(),
    safraId: (j['SafraId'] as num).toInt(),
    equipamentoId: (j['EquipamentoId'] as num).toInt(),
    tipoInformacaoId: (j['TipoInformacaoId'] as num).toInt(),
    valor: (j['Valor'] as num).toDouble(),
    data: DateTime.parse(j['Data'] as String),
  );
  Map<String, dynamic> toJson() => {
    'SafraId': safraId,
    'EquipamentoId': equipamentoId,
    'TipoInformacaoId': tipoInformacaoId,
    'Valor': valor,
    'Data': data.toIso8601String(),
  };
}
