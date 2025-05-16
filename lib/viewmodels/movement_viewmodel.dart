import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/models/movement.dart';

class MovementViewModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> crearMovimiento({
    required String tipo,
    required String categoria,
    required String descripcion,
    required double valor,
    required DateTime fecha,
    required String cuentaId,
    required String usuarioCreacion,
  }) async {
    final docRef = _db.collection('movements').doc();

    final movement = Movement(
      id: docRef.id,
      tipo: tipo,
      categoria: categoria,
      descripcion: descripcion,
      valor: valor,
      fecha: fecha,
      cuentaId: cuentaId,
      fechaCreacion: DateTime.now(),
      usuarioCreacion: usuarioCreacion,
    );

    final cuentaRef = _db.collection('accounts').doc(cuentaId);

    await _db.runTransaction((transaction) async {

      final cuentaSnapshot = await transaction.get(cuentaRef);
      if (!cuentaSnapshot.exists) {
        throw Exception('La cuenta no existe');
      }

      final cuentaData = cuentaSnapshot.data()!;
      double saldoActual = (cuentaData['saldo'] ?? 0.0) as double;


      double nuevoSaldo = tipo == AppConstants.INGRESO
          ? saldoActual + valor
          : saldoActual - valor;

      transaction.set(docRef, movement.toMap());

      transaction.update(cuentaRef, {'saldo': nuevoSaldo});
    });

    notifyListeners();
  }

  Stream<List<Movement>> listarMovimientosPorCuenta(String cuentaId) {
    return _db
        .collection('movements')
        .where('cuentaId', isEqualTo: cuentaId)
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Movement.fromMap(doc.data()))
        .toList());
  }
}
