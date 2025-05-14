import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gastos/models/usuario.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/views/home_view.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../app/constants/app_constants.dart';
import 'login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _verificarUsuario();
  }

  void _verificarUsuario() async {
    await Future.delayed(const Duration(seconds: 3));

    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      final snapshot = await _dbRef.child('users/${currentUser.uid}').get();

      if (snapshot.exists) {
        final userMap = snapshot.value as Map;
        final usuario = Usuario.fromMap(userMap);

        // Guardar en UserViewModel
        final userViewModel = Provider.of<UserViewModel>(context, listen: false);
        userViewModel.setUsuario(usuario);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeView()),
        );
        return;
      }
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppConstants.appName,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
