import 'package:flutter/material.dart';




class CadastroMedicaoPage extends StatefulWidget {
  const CadastroMedicaoPage({super.key});




  @override
  State<CadastroMedicaoPage> createState() =>
      _CadastroMedicaoPageState();
}




class _CadastroMedicaoPageState
    extends State<CadastroMedicaoPage> {
  final formKey = GlobalKey<FormState>();




  final safraController = TextEditingController();
  final equipamentoController = TextEditingController();
  final tipoInformacaoController = TextEditingController();
  final valorController = TextEditingController();




  DateTime? data;




  @override
  void dispose() {
    safraController.dispose();
    equipamentoController.dispose();
    tipoInformacaoController.dispose();
    valorController.dispose();




    super.dispose();
  }




  Future<void> selecionarData() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );




    if (dataSelecionada == null) {
      return;
    }




    final horaSelecionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );




    if (horaSelecionada == null) {
      return;
    }




    setState(() {
      data = DateTime(
        dataSelecionada.year,
        dataSelecionada.month,
        dataSelecionada.day,
        horaSelecionada.hour,
        horaSelecionada.minute,
      );
    });
  }




  void salvar() {
    if (formKey.currentState!.validate()) {
      final valor = double.tryParse(
        valorController.text.trim().replaceAll(',', '.'),
      );




      if (valor == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Informe um valor numérico válido.',
            ),
          ),
        );




        return;
      }




      print('Safra: ${safraController.text.trim()}');
      print(
        'Equipamento: '
        '${equipamentoController.text.trim()}',
      );
      print(
        'Tipo de informação: '
        '${tipoInformacaoController.text.trim()}',
      );
      print('Valor: $valor');
      print('Data: $data');




      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Medição cadastrada com sucesso!',
          ),
        ),
      );
    }
  }




  String formatarData(DateTime? data) {
    if (data == null) {
      return 'Selecione data e hora';
    }




    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year} '
        '${data.hour.toString().padLeft(2, '0')}:'
        '${data.minute.toString().padLeft(2, '0')}';
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Medição'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: safraController,
                decoration: const InputDecoration(
                  labelText: 'Safra',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a safra';
                  }




                  return null;
                },
              ),




              const SizedBox(height: 16),




              TextFormField(
                controller: equipamentoController,
                decoration: const InputDecoration(
                  labelText: 'Equipamento',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o equipamento';
                  }




                  return null;
                },
              ),




              const SizedBox(height: 16),




              TextFormField(
                controller: tipoInformacaoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de informação',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o tipo de informação';
                  }




                  return null;
                },
              ),




              const SizedBox(height: 16),




              TextFormField(
                controller: valorController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o valor';
                  }




                  final numero = double.tryParse(
                    valor.trim().replaceAll(',', '.'),
                  );




                  if (numero == null) {
                    return 'Informe um valor numérico válido';
                  }




                  return null;
                },
              ),




              const SizedBox(height: 16),




              OutlinedButton(
                onPressed: selecionarData,
                child: Text(
                  'Data: ${formatarData(data)}',
                ),
              ),




              const SizedBox(height: 24),




              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}