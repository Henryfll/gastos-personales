import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/deposit.dart';

class DepositViewModel extends ChangeNotifier {
  final CollectionReference _depositCollection = FirebaseFirestore.instance.collection('deposits');
  final CollectionReference _goalCollection = FirebaseFirestore.instance.collection('goals');

  Future<void> agregarDeposito({
    required String goalId,
    required double valor,
  }) async {
    final goalRef = _goalCollection.doc(goalId);
    final newDepositRef = _depositCollection.doc();

    final deposito = Deposit(
      id: newDepositRef.id,
      valor: valor,
      fecha: DateTime.now(),
      goalId: goalId
    );

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final goalSnapshot = await transaction.get(goalRef);

      if (!goalSnapshot.exists) {
        throw Exception('Meta no encontrada');
      }

      final currentSaldo = (goalSnapshot.data() as Map<String, dynamic>)['saldo']?.toDouble() ?? 0.0;

      // Agregar el depósito
      transaction.set(newDepositRef, deposito.toMap());

      // Actualizar el saldo de la meta
      transaction.update(goalRef, {
        'saldo': currentSaldo + valor,
      });
    });
  }


  Stream<List<Deposit>> listarDepositosPorGoal(String goalId) {
    return _depositCollection
        .where('goalId', isEqualTo: goalId)
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Deposit.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }
}
