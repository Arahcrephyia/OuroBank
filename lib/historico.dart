class Historico {

  final int? id;

  final int usuarioId;

  final String tipo;

  final double valor;

  final String descricao;

  Historico({

    this.id,

    required this.usuarioId,

    required this.tipo,

    required this.valor,

    required this.descricao,
  });


  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'usuario_id': usuarioId,
      'tipo': tipo,
      'valor': valor,
      'descricao': descricao,
    };
  }

  factory Historico.fromMap(
    Map<String, dynamic> map,
  ) {
    return Historico(
      id: map['id'],
      usuarioId: map['usuario_id'],
      tipo: map['tipo'],
      valor: map['valor'],
      descricao: map['descricao'],
    );
  }
}