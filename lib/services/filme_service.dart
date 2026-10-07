import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/filme.dart';

class FilmeService {
  Database? _db;

  Future<Database> _abrirBanco() async {
    if (_db != null) return _db!;
    final caminho = join(await getDatabasesPath(), 'filmes.db');
    _db = await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE filmes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            assistido INTEGER NOT NULL
          )
        ''');
      },
    );
    return _db!;
  }

  Future<int> inserir(Filme filme) async {
    final db = await _abrirBanco();
    return db.insert('filmes', {
      'titulo': filme.titulo,
      'assistido': filme.assistido ? 1 : 0,
    });
  }

  Future<List<Filme>> listar() async {
    final db = await _abrirBanco();
    final maps = await db.query('filmes', orderBy: 'id ASC');
    return maps.map((m) => Filme.fromMap(m)).toList();
  }

  Future<int> atualizarAssistido(int id, bool assistido) async {
    final db = await _abrirBanco();
    return db.update(
      'filmes',
      {'assistido': assistido ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
