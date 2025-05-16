class Movement {
  final String id;
  final String cuentaId;
  final String tipo;
  final String categoria;
  final String descripcion;
  final double valor;
  final DateTime fecha;
  final DateTime fechaCreacion;
  final String usuarioCreacion;

  Movement({
    required this.id,
    required this.cuentaId,
    required this.tipo,
    required this.categoria,
    required this.descripcion,
    required this.valor,
    required this.fecha,
    required this.fechaCreacion,
    required this.usuarioCreacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cuentaId': cuentaId,
      'tipo': tipo,
      'categoria': categoria,
      'descripcion': descripcion,
      'valor': valor,
      'fecha': fecha.toIso8601String(),
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'usuarioCreacion': usuarioCreacion,
    };
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
        id: map['id'],
      cuentaId: map['cuentaId'],
      tipo: map['tipo'],
      categoria: map['categoria'],
      descripcion: map['descripcion'],
      valor: (map['valor'] ?? 0).toDouble(),
      fecha: DateTime.parse(map['fecha']),
      fechaCreacion: DateTime.parse(map['fechaCreacion']),
      usuarioCreacion: map['usuarioCreacion'],
    );
  }
}