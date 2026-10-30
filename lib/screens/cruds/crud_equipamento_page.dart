import 'package:flutter/material.dart';
import '../../models/equipamento.dart';
import '../../models/unidade.dart';
import '../../services/servicos.dart';
import 'lista_crud.dart';

class CrudEquipamentoPage extends StatelessWidget {
  const CrudEquipamentoPage({super.key});
  @override
  Widget build(BuildContext context) => ListaCrud<Equipamento>(
    titulo: 'Equipamentos',
    service: equipamentoService,
    obterId: (x) => x.id,
    descricao: (x) => '${x.nome} • Unidade ${x.unidadeId}',
    formulario: (x) => FormEquipamentoPage(item: x),
  );
}

class FormEquipamentoPage extends StatefulWidget {
  final Equipamento? item;
  const FormEquipamentoPage({super.key, this.item});
  @override
  State<FormEquipamentoPage> createState() => _FormEquipamentoPageState();
}

class _FormEquipamentoPageState extends State<FormEquipamentoPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nome;
  late Future<List<Unidade>> unidades;
  int? unidadeId;
  bool salvando = false;
  @override
  void initState() {
    super.initState();
    nome = TextEditingController(text: widget.item?.nome ?? '');
    unidadeId = widget.item?.unidadeId;
    unidades = unidadeService.listar();
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => salvando = true);
    final item = Equipamento(
      id: widget.item?.id,
      nome: nome.text.trim(),
      unidadeId: unidadeId!,
    );
    try {
      if (item.id == null) {
        await equipamentoService.criar(item);
      } else {
        await equipamentoService.atualizar(item.id!, item);
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
    appBar: AppBar(title: const Text('Equipamento')),
    body: FutureBuilder<List<Unidade>>(
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
                initialValue: lista.any((x) => x.id == unidadeId)
                    ? unidadeId
                    : null,
                decoration: const InputDecoration(labelText: 'Unidade'),
                items: lista
                    .map(
                      (x) => DropdownMenuItem<int>(
                        value: x.id,
                        child: Text(x.nome),
                      ),
                    )
                    .toList(),
                onChanged: (v) => unidadeId = v,
                validator: (v) => v == null ? 'Selecione uma unidade' : null,
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
