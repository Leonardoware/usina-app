final service = CrudService(ApiConfig.safras);
FutureBuilder<List<Map<String, dynamic>>>(
future: service.listar(),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(child: CircularProgressIndicator());
}
if (snapshot.hasError) return Text('Erro: ${snapshot.error}');
final itens = snapshot.data ?? [];
if (itens.isEmpty) return const Text('Nenhuma safra cadastrada');
return ListView.builder(
itemCount: itens.length,
itemBuilder: (context, i) => ListTile(
title: Text(itens[i]['NomeSafra'].toString()),
subtitle: Text('${itens[i]['DataInicio']} a ${itens[i]['DataFim']}'),
// Acrescente IconButtons para editar e excluir.
),
);
},
)