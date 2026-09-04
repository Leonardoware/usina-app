import 'package:usina_app/models/unidadeMedida.dart';

class TipoInformacao {
  final int id;
  final String nome;
  final UnidadeMedida unidadeMedida;

  TipoInformacao({
    required this.id,
    required this.nome,
    required this.unidadeMedida,
  });
}