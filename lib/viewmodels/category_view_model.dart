import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> addCategory(String usuarioId, String categoria) async {
    final userDoc = _usersCollection.doc(usuarioId);
    final snapshot = await userDoc.get();

    List<dynamic> categorias = [];

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>?;
      categorias = data?['categorias'] ?? [];
    }

    final exists = categorias.any(
          (c) => (c as String).toLowerCase() == categoria.toLowerCase(),
    );

    if (!exists) {
      categorias.add(categoria);
      await userDoc.update({'categorias': categorias});
    }
  }

  Future<List<String>> getCategories(String usuarioId) async {
    final snapshot = await _usersCollection.doc(usuarioId).get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data?['categorias'] != null) {
        return List<String>.from(data!['categorias']);
      }
    }

    return [];
  }

  Stream<List<String>> categoriesStream(String usuarioId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(usuarioId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data?['categorias'] != null) {
          return List<String>.from(data!['categorias']);
        }
      }
      return <String>[];
    });
  }
}
