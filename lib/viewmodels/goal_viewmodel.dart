import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/goal.dart';

class GoalViewModel extends ChangeNotifier {
  final CollectionReference _goalsCollection = FirebaseFirestore.instance.collection('goals');

  Goal? _goalSelected;

  Goal? get goalSelected => _goalSelected;

  void setGoalSelected(Goal goal) {
    _goalSelected = goal;
    notifyListeners();
  }

  Stream<Goal> getGoalById(String goalId) {
    return FirebaseFirestore.instance
        .collection('goals')
        .doc(goalId)
        .snapshots()
        .map((snapshot) => Goal.fromMap(snapshot.id, snapshot.data()!));
  }


  Future<void> crearMeta({
    required String nombre,
    required double meta,
    required String userId,
  }) async {
    try {
      final newDoc = _goalsCollection.doc();

      final goal = Goal(
        id: newDoc.id,
        nombre: nombre,
        fechaCreacion: DateTime.now(),
        userId: userId,
        saldo: 0.0,
        meta: meta,
      );

      await newDoc.set(goal.toMap());
      debugPrint('Meta creada exitosamente con ID: ${goal.id}');
    } catch (e) {
      debugPrint('Error al crear la meta: $e');
      rethrow;
    }
  }

  Stream<List<Goal>> listarMetasPorUsuario(String userId) {
    return _goalsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((query) => query.docs
        .map((doc) => Goal.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> updateMeta({
    required String goalId,
    required String nombre,
    required double meta,
  }) async {
    final docRef = _goalsCollection.doc(goalId);
    await docRef.update({
      'nombre': nombre,
      'meta': meta,
    });
  }

  Future<void> deleteMeta(String goalId) async {
    final docRef = _goalsCollection.doc(goalId);
    await docRef.delete();
  }
}
