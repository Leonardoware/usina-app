import 'package:flutter/material.dart';
import 'package:usina_app/models/equipamento.dart';

class CadastroEquipamentoPage extends StatefulWidget {
  const CadastroEquipamentoPage({super.key});

  @override
  State<CadastroEquipamentoPage> createState() =>
      _CadastroEquipamentoPageState();
}

class _CadastroEquipamentoPageState
    extends State<CadastroEquipamentoPage> {
  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final unidadeController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    unidadeController.dispose();

    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      print('Nome: ${nomeController.text.trim()}');
      print('Unidade: ${unidadeController.text.trim()}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Equipamento cadastrado com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Equipamento'),
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
                controller: unidadeController,
                decoration: const InputDecoration(
                  labelText: 'Unidade',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a unidade';
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