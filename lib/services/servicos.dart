import 'package:usina_app/services/config/api_config.dart';
import 'package:usina_app/models/safra.dart';
import 'package:usina_app/models/unidade.dart';
import 'package:usina_app/models/unidadeMedida.dart';
import 'package:usina_app/models/equipamento.dart';
import 'package:usina_app/models/tipoInformacao.dart';
import 'package:usina_app/models/medicao.dart';
import 'api_service.dart';

final safraService = ApiService<Safra>(
  endpoint: ApiConfig.safras,
  fromJson: Safra.fromJson,
  toJson: (x) => x.toJson(),
);
final unidadeService = ApiService<Unidade>(
  endpoint: ApiConfig.unidades,
  fromJson: Unidade.fromJson,
  toJson: (x) => x.toJson(),
);

final unidadeMedidaService = ApiService<UnidadeMedida>(
  endpoint: ApiConfig.unidadesMedida,
  fromJson: UnidadeMedida.fromJson,
  toJson: (x) => x.toJson(),
);
final equipamentoService = ApiService<Equipamento>(
  endpoint: ApiConfig.equipamentos,
  fromJson: Equipamento.fromJson,
  toJson: (x) => x.toJson(),
);
final tipoInformacaoService = ApiService<TipoInformacao>(
  endpoint: ApiConfig.tipos,
  fromJson: TipoInformacao.fromJson,
  toJson: (x) => x.toJson(),
);
final medicaoService = ApiService<Medicao>(
  endpoint: ApiConfig.medicoes,
  fromJson: Medicao.fromJson,
  toJson: (x) => x.toJson(),
);
