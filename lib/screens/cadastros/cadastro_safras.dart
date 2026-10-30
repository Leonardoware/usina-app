import 'package:flutter/material.dart';




class CadastroSafraPage extends StatefulWidget {
  const CadastroSafraPage({super.key});




  @override
  State<CadastroSafraPage> createState() =>
      _CadastroSafraPageState();
}




class _CadastroSafraPageState
    extends State<CadastroSafraPage> {
  final formKey = GlobalKey<FormState>();




  final nomeController = TextEditingController();




  DateTime? dataInicio;
  DateTime? dataFim;




  @override
  void dispose() {
    nomeController.dispose();




    super.dispose();
  }




  Future<void> selecionarDataInicio() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );




    if (data != null) {
      setState(() {
        dataInicio = data;
      });
    }
  }




  Future<void> selecionarDataFim() async {
    final data = await showDatePicker(
      context: context,
      initialDate: dataInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );




    if (data != null) {
      setState(() {
        dataFim = data;
      });
    }
  }




  void salvar() {
    if (formKey.currentState!.validate()) {
      print('Nome: ${nomeController.text.trim()}');
      print('Data início: $dataInicio');
      print('Data fim: $dataFim');




      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Safra cadastrada com sucesso!',
          ),
        ),
      );
    }
  }




  String formatarData(DateTime? data) {
    if (data == null) {
      return 'Selecione uma data';
    }




    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Safra'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome';
                  }




                  return null;
                },
              ),




              const SizedBox(height: 16),




              OutlinedButton(
                onPressed: selecionarDataInicio,
                child: Text(
                  'Data de início: ${formatarData(dataInicio)}',
                ),
              ),




              const SizedBox(height: 16),




              OutlinedButton(
                onPressed: selecionarDataFim,
                child: Text(
                  'Data de fim: ${formatarData(dataFim)}',
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