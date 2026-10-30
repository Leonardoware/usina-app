class Safra {
  final int? id;
  final String nomeSafra;
  final DateTime dataInicio;
  final DateTime dataFim;
  const Safra({
    this.id,
    required this.nomeSafra,
    required this.dataInicio,
    required this.dataFim,
  });
  factory Safra.fromJson(Map<String, dynamic> j) => Safra(
    id: (j['Id'] as num?)?.toInt(),
    nomeSafra: j['NomeSafra'] as String? ?? '',
    dataInicio: DateTime.parse(j['DataInicio'] as String),
    dataFim: DateTime.parse(j['DataFim'] as String),
  );
  Map<String, dynamic> toJson() => {
    'NomeSafra': nomeSafra,
    'DataInicio': dataInicio.toIso8601String().substring(0, 10),
    'DataFim': dataFim.toIso8601String().substring(0, 10),
  };
}
