import 'package:usina_app/models/unidade.dart';

class Equipamento {
  final int id;
  final String nome;
  final Unidade unidade;

  Equipamento({
    required this.id,
    required this.nome,
    required this.unidade,
  });
}