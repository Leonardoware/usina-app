import 'package:flutter/material.dart';
import '../../models/safra.dart';
import '../../services/servicos.dart';
import 'lista_crud.dart';

class CrudSafraPage extends StatelessWidget {
  const CrudSafraPage({super.key});
  @override
  Widget build(BuildContext context) => ListaCrud<Safra>(
    titulo: 'Safras',
    service: safraService,
    obterId: (x) => x.id,
    descricao: (x) => x.nomeSafra,
    formulario: (x) => FormSafraPage(item: x),
  );
}

class FormSafraPage extends StatefulWidget {
  final Safra? item;
  const FormSafraPage({super.key, this.item});
  @override
  State<FormSafraPage> createState() => _FormSafraPageState();
}

class _FormSafraPageState extends State<FormSafraPage> {
  final keyForm = GlobalKey<FormState>();
  late final TextEditingController nome;
  late DateTime inicio;
  late DateTime fim;
  bool salvando = false;
  @override
  void initState() {
    super.initState();
    nome = TextEditingController(text: widget.item?.nomeSafra ?? '');
    inicio = widget.item?.dataInicio ?? DateTime.now();

    fim = widget.item?.dataFim ?? DateTime.now();
  }

  Future<void> escolherData(bool dataInicio) async {
    final atual = dataInicio ? inicio : fim;
    final escolhida = await showDatePicker(
      context: context,
      initialDate: atual,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (escolhida == null) return;
    setState(() {
      if (dataInicio) {
        inicio = escolhida;
      } else {
        fim = escolhida;
      }
    });
  }

  String formatar(DateTime data) =>
      '${data.day.toString().padLeft(2, '0')}/'
      '${data.month.toString().padLeft(2, '0')}/${data.year}';
  Future<void> salvar() async {
    if (!keyForm.currentState!.validate()) return;
    if (fim.isBefore(inicio)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Fim anterior ao início.')));
      return;
    }
    setState(() => salvando = true);
    final item = Safra(
      id: widget.item?.id,
      nomeSafra: nome.text.trim(),
      dataInicio: inicio,
      dataFim: fim,
    );
    try {
      if (item.id == null) {
        await safraService.criar(item);
      } else {
        await safraService.atualizar(item.id!, item);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
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
    appBar: AppBar(
      title: Text(widget.item == null ? 'Nova safra' : 'Editar safra'),
    ),
    body: Form(
      key: keyForm,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: nome,
            decoration: const InputDecoration(labelText: 'Nome da safra'),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Informe o nome' : null,
          ),
          ListTile(
            title: Text('Início: ${formatar(inicio)}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => escolherData(true),
          ),
          ListTile(
            title: Text('Fim: ${formatar(fim)}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => escolherData(false),
          ),
          ElevatedButton(
            onPressed: salvando ? null : salvar,
            child: const Text('Salvar'),
          ),
        ],
      ),
    ),
  );
}
