import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gastos/models/usuario.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  Usuario? _usuario;

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print('Inicio de sesión con Google cancelado por el usuario.');
        return false;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {

        final userRef = _dbRef.child("users").child(user.uid);

        final DataSnapshot snapshot = await userRef.get();
        if (!snapshot.exists) {

          _usuario = Usuario(
            uid: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            photoUrl: user.photoURL,
            cuentas: [],
          );
          await userRef.set(_usuario!.toMap());
        }else {
          _usuario = Usuario.fromMap(snapshot.value as Map);
        }
        final userViewModel = Provider.of<UserViewModel>(context, listen: false);
        userViewModel.setUsuario(_usuario as Usuario);
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
      print('Cierre de sesión de Firebase exitoso.');
      await GoogleSignIn().signOut();
      print('Cierre de sesión de Google exitoso.');
    } catch (e) {
      print('Error al cerrar sesión: $e');
      // throw e;
    }
  }

}
