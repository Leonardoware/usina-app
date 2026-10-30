import 'package:flutter/material.dart';
import '../../models/medicao.dart';
import '../../models/safra.dart';
import '../../models/equipamento.dart';
import 'package:usina_app/models/tipoInformacao.dart';
import '../../services/servicos.dart';
import 'lista_crud.dart';

class CrudMedicaoPage extends StatelessWidget {
  const CrudMedicaoPage({super.key});
  @override
  Widget build(BuildContext context) => ListaCrud<Medicao>(
    titulo: 'Medições',
    service: medicaoService,
    obterId: (x) => x.id,
    descricao: (x) =>
        'Valor ${x.valor} • ${x.data.day}/'
        '${x.data.month}/${x.data.year}',
    formulario: (x) => FormMedicaoPage(item: x),
  );
}

class FormMedicaoPage extends StatefulWidget {
  final Medicao? item;
  const FormMedicaoPage({super.key, this.item});
  @override
  State<FormMedicaoPage> createState() => _FormMedicaoPageState();
}

class _FormMedicaoPageState extends State<FormMedicaoPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController valor;
  late Future<List<dynamic>> referencias;
  int? safraId;
  int? equipamentoId;
  int? tipoId;
  late DateTime data;

  bool salvando = false;
  @override
  void initState() {
    super.initState();
    valor = TextEditingController(text: widget.item?.valor.toString() ?? '');
    safraId = widget.item?.safraId;
    equipamentoId = widget.item?.equipamentoId;
    tipoId = widget.item?.tipoInformacaoId;
    data = widget.item?.data ?? DateTime.now();
    referencias = Future.wait<dynamic>([
      safraService.listar(),
      equipamentoService.listar(),
      tipoInformacaoService.listar(),
    ]);
  }

  Future<void> escolherData() async {
    final nova = await showDatePicker(
      context: context,
      initialDate: data,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (nova == null || !mounted) return;
    final hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(data),
    );
    if (hora == null) return;
    setState(() {
      data = DateTime(nova.year, nova.month, nova.day, hora.hour, hora.minute);
    });
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => salvando = true);
    final item = Medicao(
      id: widget.item?.id,
      safraId: safraId!,
      equipamentoId: equipamentoId!,
      tipoInformacaoId: tipoId!,
      valor: double.parse(valor.text.trim().replaceAll(',', '.')),
      data: data,
    );
    try {
      if (item.id == null) {
        await medicaoService.criar(item);
      } else {
        await medicaoService.atualizar(item.id!, item);
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
    valor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Medição')),

    body: FutureBuilder<List<dynamic>>(
      future: referencias,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final safras = snapshot.data![0] as List<Safra>;
        final equipamentos = snapshot.data![1] as List<Equipamento>;
        final tipos = snapshot.data![2] as List<TipoInformacao>;
        return Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButtonFormField<int>(
                initialValue: safras.any((x) => x.id == safraId)
                    ? safraId
                    : null,
                decoration: const InputDecoration(labelText: 'Safra'),
                items: safras
                    .map(
                      (x) => DropdownMenuItem(
                        value: x.id,
                        child: Text(x.nomeSafra),
                      ),
                    )
                    .toList(),
                onChanged: (v) => safraId = v,
                validator: (v) => v == null ? 'Selecione a safra' : null,
              ),
              DropdownButtonFormField<int>(
                initialValue: equipamentos.any((x) => x.id == equipamentoId)
                    ? equipamentoId
                    : null,
                decoration: const InputDecoration(labelText: 'Equipamento'),
                items: equipamentos
                    .map(
                      (x) => DropdownMenuItem(value: x.id, child: Text(x.nome)),
                    )
                    .toList(),
                onChanged: (v) => equipamentoId = v,
                validator: (v) => v == null ? 'Selecione o equipamento' : null,
              ),
              DropdownButtonFormField<int>(
                initialValue: tipos.any((x) => x.id == tipoId) ? tipoId : null,
                decoration: const InputDecoration(
                  labelText: 'Tipo de informação',
                ),
                items: tipos
                    .map(
                      (x) => DropdownMenuItem(value: x.id, child: Text(x.nome)),
                    )
                    .toList(),
                onChanged: (v) => tipoId = v,
                validator: (v) => v == null ? 'Selecione o tipo' : null,
              ),
              TextFormField(
                controller: valor,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Valor'),
                validator: (v) {
                  final n = double.tryParse(
                    (v ?? '').trim().replaceAll(',', '.'),
                  );
                  return n == null ? 'Informe um número válido' : null;
                },
              ),
              ListTile(
                title: Text(
                  'Data: ${data.day}/${data.month}/${data.year} '
                  '${data.hour}:${data.minute.toString().padLeft(2, '0')}',
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: escolherData,
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
