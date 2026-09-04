import 'package:flutter/material.dart';
import 'package:usina_app/models/tipoInformacao.dart';

class CadastroTipoInformacaoPage extends StatefulWidget {
  const CadastroTipoInformacaoPage({super.key});

  @override
  State<CadastroTipoInformacaoPage> createState() =>
      _CadastroTipoInformacaoPageState();
}

class _CadastroTipoInformacaoPageState
    extends State<CadastroTipoInformacaoPage> {
  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final unidadeMedidaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    unidadeMedidaController.dispose();

    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      print('Nome: ${nomeController.text.trim()}');
      print(
        'Unidade de medida: '
        '${unidadeMedidaController.text.trim()}',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tipo de informação cadastrado com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tipo de Informação'),
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
                controller: unidadeMedidaController,
                decoration: const InputDecoration(
                  labelText: 'Unidade de medida',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a unidade de medida';
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