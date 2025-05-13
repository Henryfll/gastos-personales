import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {

  Future<bool> signInWithGoogle() async {
    try {
      // Paso 1: Iniciar el flujo de inicio de sesión de Google
      // Le pedimos al paquete google_sign_in que comience el proceso.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Si el usuario cancela el inicio de sesión, googleUser será null
      if (googleUser == null) {
        print('Inicio de sesión con Google cancelado por el usuario.');
        return false; // Retornar null si el usuario canceló
      }
      // Paso 2: Obtener los detalles de autenticación del usuario de Google
      // Una vez que el usuario inicia sesión con Google, obtenemos sus credenciales.
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Paso 3: Crear una credencial de Firebase a partir de las credenciales de Google
      // Usamos el ID token y el Access token de Google para crear una credencial que Firebase entiende.
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Paso 4: Iniciar sesión en Firebase con la credencial de Google
      // Ahora usamos la credencial de Firebase creada para autenticar al usuario en Firebase.
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Si todo fue bien, userCredential contiene la información del usuario autenticado en Firebase.
      print('Inicio de sesión con Google exitoso: ${userCredential.user?.displayName}');

      return true;
    } catch (e) {
      print('Error en login con Google: $e');
      return false;
    }
  }
}
