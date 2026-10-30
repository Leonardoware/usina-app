import 'package:flutter/material.dart';
import '../../models/unidadeMedida.dart';
import '../../services/servicos.dart';
import 'lista_crud.dart';

class CrudUnidadeMedidaPage extends StatelessWidget {
  const CrudUnidadeMedidaPage({super.key});
  @override
  Widget build(BuildContext context) => ListaCrud<UnidadeMedida>(
    titulo: 'Unidades de medida',
    service: unidadeMedidaService,
    obterId: (x) => x.id,
    descricao: (x) => '${x.nome} (${x.simbolo})',
    formulario: (x) => FormUnidadeMedidaPage(item: x),
  );
}

class FormUnidadeMedidaPage extends StatefulWidget {
  final UnidadeMedida? item;
  const FormUnidadeMedidaPage({super.key, this.item});
  @override
  State<FormUnidadeMedidaPage> createState() => _FormUnidadeMedidaPageState();
}

class _FormUnidadeMedidaPageState extends State<FormUnidadeMedidaPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nome;
  late final TextEditingController simbolo;
  bool salvando = false;
  @override
  void initState() {
    super.initState();
    nome = TextEditingController(text: widget.item?.nome ?? '');
    simbolo = TextEditingController(text: widget.item?.simbolo ?? '');
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => salvando = true);
    final item = UnidadeMedida(
      id: widget.item?.id,
      nome: nome.text.trim(),
      simbolo: simbolo.text.trim(),
    );
    try {
      if (item.id == null) {
        await unidadeMedidaService.criar(item);
      } else {
        await unidadeMedidaService.atualizar(item.id!, item);
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
    simbolo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Unidade de medida')),
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
          TextFormField(
            controller: simbolo,
            decoration: const InputDecoration(labelText: 'Símbolo'),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Informe o símbolo' : null,
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
