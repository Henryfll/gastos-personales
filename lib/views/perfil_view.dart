import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/viewmodels/login_viewmodel.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/widgets/templates/footer/footer.dart';
import 'package:provider/provider.dart';
import 'login_view.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  void _cerrarSesion(BuildContext context) async {
    final loginVM = context.read<LoginViewModel>();
    final userVM = context.read<UserViewModel>();

    await loginVM.logout();
    await userVM.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UserViewModel>(context).usuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(90.sp, 50.sp,10.sp,90.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.sp,
              backgroundImage: NetworkImage(usuario?.photoUrl ?? ''),
            ),
            SizedBox(height: 16.sp),
            Text(
              usuario?.name ?? 'Nombre no disponible',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.sp),
            Text(
              usuario?.email ?? 'Correo no disponible',
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32.sp),
            ElevatedButton.icon(
              onPressed: () => _cerrarSesion(context),
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorsUI.secondary500,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(page: 3),
    );
  }
}
