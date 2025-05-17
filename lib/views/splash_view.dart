import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/views/home_view.dart';
import 'package:gastos/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:gastos/app/constants/app_constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _verificarUsuario();
  }

  void _verificarUsuario() async {
    await Future.delayed(const Duration(seconds: 3));
    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);

      final usuarioCargado =
      await userViewModel.loadUsuarioDesdeFirestore(currentUser.uid);

      if (usuarioCargado) {
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
      backgroundColor: colorsUI.secondary500,
    );
  }
}
