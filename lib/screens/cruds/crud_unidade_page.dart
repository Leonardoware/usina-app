import 'package:flutter/material.dart';
import '../../models/unidade.dart';
import '../../services/servicos.dart';
import 'lista_crud.dart';

class CrudUnidadePage extends StatelessWidget {
  const CrudUnidadePage({super.key});
  @override
  Widget build(BuildContext context) => ListaCrud<Unidade>(
    titulo: 'Unidades',
    service: unidadeService,
    obterId: (x) => x.id,
    descricao: (x) => x.nome,
    formulario: (x) => FormUnidadePage(item: x),
  );
}

class FormUnidadePage extends StatefulWidget {
  final Unidade? item;
  const FormUnidadePage({super.key, this.item});
  @override
  State<FormUnidadePage> createState() => _FormUnidadePageState();
}

class _FormUnidadePageState extends State<FormUnidadePage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nome;
  bool salvando = false;
  @override
  void initState() {
    super.initState();
    nome = TextEditingController(text: widget.item?.nome ?? '');
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => salvando = true);
    final item = Unidade(id: widget.item?.id, nome: nome.text.trim());
    try {
      if (item.id == null) {
        await unidadeService.criar(item);
      } else {
        await unidadeService.atualizar(item.id!, item);
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
    appBar: AppBar(title: const Text('Cadastro de Unidade')),
    body: Form(
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: salvando ? null : salvar,
            child: const Text('Salvar'),
          ),
        ],
      ),
    ),
  );
}
