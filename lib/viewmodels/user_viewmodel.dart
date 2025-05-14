import 'package:flutter/material.dart';
import 'package:gastos/models/usuario.dart';

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
}
