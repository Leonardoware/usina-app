import 'package:usina_app/models/equipamento.dart';
import 'package:usina_app/models/safra.dart';
import 'package:usina_app/models/tipoInformacao.dart';

class Medicao {
  final int id;
  final double valor;
  final DateTime data;
  final Safra safra;
  final Equipamento equipamento;
  final TipoInformacao tipoInformacao;

  Medicao({
    required this.id,
    required this.valor,
    required this.data,
    required this.safra,
    required this.equipamento,
    required this. tipoInformacao,
  });
}