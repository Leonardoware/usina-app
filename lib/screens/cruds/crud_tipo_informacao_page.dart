import 'package:flutter/material.dart';
import 'package:usina_app/models/tipoInformacao.dart';
import 'package:usina_app/models/unidadeMedida.dart';
import '../../services/servicos.dart';
import 'lista_crud.dart';

class CrudTipoInformacaoPage extends StatelessWidget {
  const CrudTipoInformacaoPage({super.key});
  @override
  Widget build(BuildContext context) => ListaCrud<TipoInformacao>(
    titulo: 'Tipos de informação',
    service: tipoInformacaoService,
    obterId: (x) => x.id,
    descricao: (x) => '${x.nome} • Medida ${x.unidadeMedidaId}',
    formulario: (x) => FormTipoInformacaoPage(item: x),
  );
}

class FormTipoInformacaoPage extends StatefulWidget {
  final TipoInformacao? item;
  const FormTipoInformacaoPage({super.key, this.item});
  @override
  State<FormTipoInformacaoPage> createState() => _FormTipoInformacaoPageState();
}

class _FormTipoInformacaoPageState extends State<FormTipoInformacaoPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nome;
  late Future<List<UnidadeMedida>> unidades;
  int? unidadeMedidaId;
  bool salvando = false;
  @override
  void initState() {
    super.initState();
    nome = TextEditingController(text: widget.item?.nome ?? '');
    unidadeMedidaId = widget.item?.unidadeMedidaId;
    unidades = unidadeMedidaService.listar();
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => salvando = true);
    final item = TipoInformacao(
      id: widget.item?.id,
      nome: nome.text.trim(),
      unidadeMedidaId: unidadeMedidaId!,
    );
    try {
      if (item.id == null) {
        await tipoInformacaoService.criar(item);
      } else {
        await tipoInformacaoService.atualizar(item.id!, item);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => salvando = false);
    }
  }

  @override
  void dispose() {
    nome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Tipo de informação')),
    body: FutureBuilder<List<UnidadeMedida>>(
      future: unidades,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final lista = snapshot.data!;
        return Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: nome,

                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Informe o nome' : null,
              ),
              DropdownButtonFormField<int>(
                initialValue: lista.any((x) => x.id == unidadeMedidaId)
                    ? unidadeMedidaId
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Unidade de medida',
                ),
                items: lista
                    .map(
                      (x) => DropdownMenuItem<int>(
                        value: x.id,
                        child: Text('${x.nome} (${x.simbolo})'),
                      ),
                    )
                    .toList(),
                onChanged: (v) => unidadeMedidaId = v,
                validator: (v) =>
                    v == null ? 'Selecione a unidade de medida' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvando ? null : salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        );
      },
    ),
  );
}
