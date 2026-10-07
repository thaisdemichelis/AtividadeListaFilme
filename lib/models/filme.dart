class Filme {
  final int? id;
  final String titulo;
  final bool assistido;

  Filme({this.id, required this.titulo, this.assistido = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'assistido': assistido ? 1 : 0,
    };
  }

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'] as int?,
      titulo: map['titulo'] as String,
      assistido: map['assistido'] == 1,
    );
  }

  Filme copyWith({int? id, String? titulo, bool? assistido}) {
    return Filme(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      assistido: assistido ?? this.assistido,
    );
  }
}
