import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/models/usuario.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Usuario? _usuario;

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print('Inicio de sesión con Google cancelado por el usuario.');
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = _firestore.collection("users").doc(user.uid);

        final docSnapshot = await userDoc.get();

        if (!docSnapshot.exists) {
          _usuario = Usuario(
            uid: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            photoUrl: user.photoURL,
            cuentas: [],
            categorias:AppConstants.listaInicialCategorias
          );
          await userDoc.set(_usuario!.toMap());
        } else {
          _usuario = Usuario.fromMap(docSnapshot.data()!);
        }

        final userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
        userViewModel.setUsuario(_usuario!);
        return true;
      }

      print('Inicio de sesión con Google exitoso: ${userCredential.user?.displayName}');
      return false;
    } catch (e) {
      print('Error en login con Google: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      print('Cierre de sesión exitoso.');
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }
}
