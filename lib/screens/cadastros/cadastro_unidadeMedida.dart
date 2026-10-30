import 'package:flutter/material.dart';




class CadastroUnidadeMedidaPage extends StatefulWidget {
  const CadastroUnidadeMedidaPage({super.key});




  @override
  State<CadastroUnidadeMedidaPage> createState() =>
      _CadastroUnidadeMedidaPageState();
}




class _CadastroUnidadeMedidaPageState
    extends State<CadastroUnidadeMedidaPage> {
  final formKey = GlobalKey<FormState>();




  final nomeController = TextEditingController();
  final simboloController = TextEditingController();




  @override
  void dispose() {
    nomeController.dispose();
    simboloController.dispose();




    super.dispose();
  }




  void salvar() {
    if (formKey.currentState!.validate()) {
      print('Nome: ${nomeController.text.trim()}');
      print('Símbolo: ${simboloController.text.trim()}');




      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unidade de medida cadastrada com sucesso!',
          ),
        ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Unidade de Medida'),
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




              TextFormField(
                controller: simboloController,
                decoration: const InputDecoration(
                  labelText: 'Símbolo',
                  hintText: 'Ex.: kg, L, °C',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o símbolo';
                  }




                  return null;
                },
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