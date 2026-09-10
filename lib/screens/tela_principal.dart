import 'package:flutter/material.dart';
import 'cadastros/cadastro_equipamento.dart';
import 'cadastros/cadastro_indicador.dart';
import 'cadastros/cadastro_medicao.dart';
import 'cadastros/cadastro_safras.dart';
import 'cadastros/cadastro_tipoInformacao.dart';
import 'cadastros/cadastro_unidade.dart';
import 'cadastros/cadastro_unidadeMedida.dart';
import 'cadastros/cadastro_usuario.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool cadastroAberto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usina App'),
      ),
      drawer: Drawer(
        child: montarMenu(),
      ),
    );
  }


    Widget montarMenu() {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        child: Text(
          'Menu Principal',
          style: TextStyle(fontSize: 22),
        ),
      ),

      const ListTile(
        leading: Icon(Icons.home),
        title: Text('Início'),
      ),

      ListTile(
        leading: const Icon(Icons.app_registration),
        title: const Text('Cadastro'),
        trailing: Icon(
          cadastroAberto
              ? Icons.expand_less
              : Icons.expand_more,
        ),
        onTap: () {
          setState(() {
            cadastroAberto = !cadastroAberto;
          });
        },
      ),

      if (cadastroAberto) ...[
  ListTile(
    leading: const Icon(Icons.agriculture),
    title: const Text('Safra'),
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroSafraPage(),
        ),
      );
    },
  ),

  ListTile(
    leading: const Icon(Icons.business),
    title: const Text('Unidade'),
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroUnidadePage(),
        ),
      );
    },
  ),

  ListTile(
    leading: const Icon(Icons.devices),
    title: const Text('Equipamento'),
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroEquipamentoPage(),
        ),
      );
    },
  ),

  ListTile(
    leading: const Icon(Icons.analytics),
    title: const Text('Medição'),
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroMedicaoPage(),
        ),
      );
    },
  ),

  ListTile(
    leading: const Icon(Icons.straighten),
    title: const Text('Unidade de Medida'),
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroUnidadeMedidaPage(),
        ),
      );
    },
  ),

  ListTile(
    leading: const Icon(Icons.info),
    title: const Text('Tipo de Informação'),
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroTipoInformacaoPage(),
        ),
      );
    },
  ),

  ListTile(
    leading: const Icon(Icons.bar_chart),
    title: const Text('Indicador'),
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroIndicadorPage(),
        ),
      );
    },
  ),

  ListTile(
  leading: const Icon(Icons.chevron_right),
  title: const Text('Usuário'),
  onTap: () {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CadastroUsuarioPage(),
        ),
      );
    },
  ),
],
    ],
  );
}

}
