import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/account.dart';

class AccountViewModel extends ChangeNotifier {
  final CollectionReference _accountsCollection = FirebaseFirestore.instance.collection('accounts');

  List<Account> _accounts = [];

  List<Account> get accounts => _accounts;

  Stream<List<Account>> accountsStream(String usuarioId) {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(usuarioId);

    return userDoc.snapshots().asyncMap((snapshot) async {
      final data = snapshot.data();
      if (data == null || data['cuentas'] == null) return [];

      List<String> accountIds = List<String>.from(data['cuentas']);

      if (accountIds.isEmpty) return [];

      final accountDocs = await _accountsCollection.where(FieldPath.documentId, whereIn: accountIds).get();

      return accountDocs.docs.map((doc) {
        return Account.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }


  Future<void> addAccount({
    required String nombre,
    required String descripcion,
    required String usuarioId,
  }) async {
    final newDoc = _accountsCollection.doc();

    final account = Account(
      id: newDoc.id,
      nombre: nombre,
      descripcion: descripcion,
      fechaCreacion: DateTime.now(),
      userId: usuarioId,
      saldo: 0.0,
    );

    await newDoc.set(account.toMap());

    // Actualiza la lista de cuentas del usuario en la colección "users"
    final userDoc = FirebaseFirestore.instance.collection('users').doc(usuarioId);
    final userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      List<dynamic> cuentas = userSnapshot.data()?['cuentas'] ?? [];
      cuentas = List<String>.from(cuentas);
      cuentas.add(account.id);
      await userDoc.update({'cuentas': cuentas});
    } else {
      await userDoc.set({'cuentas': [account.id]}, SetOptions(merge: true));
    }
  }

  Future<void> updateAccount({
    required String accountId,
    required String nombre,
    required String descripcion,
  }) async {
    final docRef = _accountsCollection.doc(accountId);

    await docRef.update({
      'nombre': nombre,
      'descripcion': descripcion,
    });
  }
  Future<void> deleteAccount({
    required String accountId,
    required String userId,
  }) async {
    final docRef = _accountsCollection.doc(accountId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      throw Exception('La cuenta no existe');
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    final creadorId = data['userId'];

    if (creadorId != userId) {
      throw Exception('No tienes permiso para eliminar esta cuenta');
    }


    await docRef.delete();


    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      List<dynamic> cuentas = userSnapshot.data()?['cuentas'] ?? [];
      cuentas = List<String>.from(cuentas)..remove(accountId);
      await userDoc.update({'cuentas': cuentas});
    }
  }

  Future<String> shareAccount({
    required String accountId,
    required String email,
  }) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final querySnapshot = await usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isEmpty) {
      return 'Usuario no encontrado';
    }

    final userDoc = querySnapshot.docs.first;
    final userId = userDoc.id;

    List<dynamic> cuentas = userDoc.data()['cuentas'] ?? [];
    cuentas = List<String>.from(cuentas);

    if (cuentas.contains(accountId)) {
      return 'La cuenta ya está compartida con este usuario';
    }

    cuentas.add(accountId);
    await usersCollection.doc(userId).update({'cuentas': cuentas});

    return 'Cuenta compartida con éxito';
  }


}
