class Goal {
  final String id;
  final String nombre;
  final DateTime fechaCreacion;
  final String userId;
  final double saldo;
  final double meta;

  Goal({
    required this.id,
    required this.nombre,
    required this.fechaCreacion,
    required this.userId,
    required this.saldo,
    required this.meta,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'userId': userId,
      'saldo': saldo,
      'meta': meta,
    };
  }

  factory Goal.fromMap(String id, Map<String, dynamic> map) {
    return Goal(
      id: id,
      nombre: map['nombre'] ?? '',
      fechaCreacion: DateTime.parse(map['fechaCreacion']),
      userId: map['userId'] ?? '',
      saldo: (map['saldo'] ?? 0).toDouble(),
      meta: (map['meta'] ?? 0).toDouble(),
    );
  }
}
