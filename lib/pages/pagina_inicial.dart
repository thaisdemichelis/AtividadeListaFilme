import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/filme_viewmodel.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilmeViewModel>().carregarFilmes();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _adicionar() async {
    final texto = _controller.text;
    _controller.clear();
    await context.read<FilmeViewModel>().adicionarFilme(texto);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FilmeViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Lista de Filmes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Digite o nome do filme',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _adicionar(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _adicionar,
              child: const Text('Adicionar'),
            ),
            const Divider(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.filmes.length,
                itemBuilder: (context, index) {
                  final filme = viewModel.filmes[index];
                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(
                      filme.titulo,
                      style: TextStyle(
                        decoration: filme.assistido
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Checkbox(
                      value: filme.assistido,
                      onChanged: (valor) {
                        viewModel.alterarAssistido(filme, valor ?? false);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
