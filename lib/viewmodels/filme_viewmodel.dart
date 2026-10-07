import 'package:flutter/foundation.dart';

import '../../models/filme.dart';
import '../../services/filme_service.dart';

class FilmeViewModel extends ChangeNotifier {
  final FilmeService _service = FilmeService();
  List<Filme> _filmes = [];

  List<Filme> get filmes => _filmes;

  Future<void> carregarFilmes() async {
    _filmes = await _service.listar();
    notifyListeners();
  }

  Future<void> adicionarFilme(String titulo) async {
    final texto = titulo.trim();
    if (texto.isEmpty) return;
    await _service.inserir(Filme(titulo: texto));
    _filmes = await _service.listar();
    notifyListeners();
  }

  Future<void> alterarAssistido(Filme filme, bool assistido) async {
    if (filme.id == null) return;
    await _service.atualizarAssistido(filme.id!, assistido);
    _filmes = await _service.listar();
    notifyListeners();
  }
}
