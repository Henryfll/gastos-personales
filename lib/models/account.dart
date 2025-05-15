import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String id;
  final String nombre;
  final String descripcion;
  final DateTime fechaCreacion;
  final String userId;
  final double saldo;

  Account({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.fechaCreacion,
    required this.userId,
    required this.saldo,
  });


  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha_creacion': Timestamp.fromDate(fechaCreacion),
      'user_id': userId,
      'saldo': saldo,
    };
  }


  factory Account.fromMap(String id, Map<String, dynamic> map) {
    return Account(
      id: id,
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'] ?? '',
      fechaCreacion: (map['fecha_creacion'] as Timestamp).toDate(),
      userId: map['user_id'] ?? '',
      saldo: (map['saldo'] as num).toDouble(),
    );
  }
}
