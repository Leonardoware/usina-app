import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ListaCrud<T> extends StatefulWidget {
  final String titulo;
  final ApiService<T> service;
  final int? Function(T) obterId;
  final String Function(T) descricao;
  final Widget Function(T?) formulario;
  const ListaCrud({
    super.key,
    required this.titulo,
    required this.service,
    required this.obterId,
    required this.descricao,
    required this.formulario,
  });
  @override
  State<ListaCrud<T>> createState() => _ListaCrudState<T>();
}

class _ListaCrudState<T> extends State<ListaCrud<T>> {
  late Future<List<T>> dados;
  @override
  void initState() {
    super.initState();
    recarregar();
  }

  void recarregar() {
    setState(() => dados = widget.service.listar());
  }

  Future<void> abrir(T? item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => widget.formulario(item)),
    );
    if (mounted) recarregar();
  }

  Future<void> excluir(T item) async {
    final id = widget.obterId(item);
    if (id == null) return;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir registro?'),
        content: Text(widget.descricao(item)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmar != true) return;
    try {
      await widget.service.excluir(id);
      if (!mounted) return;
      recarregar();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao excluir: $e')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.titulo)),
    floatingActionButton: FloatingActionButton(
      onPressed: () => abrir(null),
      child: const Icon(Icons.add),
    ),
    body: FutureBuilder<List<T>>(
      future: dados,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Erro: ${snapshot.error}'),
                ElevatedButton(
                  onPressed: recarregar,
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final itens = snapshot.data!;
        if (itens.isEmpty) {
          return const Center(child: Text('Nenhum registro cadastrado.'));
        }
        return RefreshIndicator(
          onRefresh: () async {
            recarregar();
            await dados;
          },
          child: ListView.builder(
            itemCount: itens.length,
            itemBuilder: (context, index) {
              final item = itens[index];
              return ListTile(
                title: Text(widget.descricao(item)),
                subtitle: Text('ID: ${widget.obterId(item)}'),
                trailing: Wrap(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => abrir(item),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => excluir(item),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ),
  );
}
