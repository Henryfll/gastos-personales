import 'package:flutter/material.dart';
import 'package:gastos/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserViewModel extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void clearUsuario() {
    _usuario = null;
    notifyListeners();
  }

  Future<void> logout() async {
    clearUsuario();
  }

  Future<bool> loadUsuarioDesdeFirestore(String uid) async {
    try {
      final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        _usuario = Usuario.fromMap(userDoc.data()!);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error al cargar usuario desde Firestore: $e');
      return false;
    }
  }
}
