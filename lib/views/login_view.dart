import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/app/utils/paths/icons/icons.dart';
import 'package:gastos/views/home_view.dart';
import 'package:gastos/widgets/molecules/buttons/custom_icon_text_button_mobile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../app/constants/app_constants.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void _handleLogin(BuildContext context) async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final success = await loginViewModel.signInWithGoogle(context);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConstants.appName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 250,
              child: Lottie.asset(iconsUI.money),
            ),

            SizedBox(height: 10.sp),
            GestureDetector(
              onTap: () => _handleLogin(context),
              child: CustomIconTextButtonMobile(
                  color: Colors.white,
                  border: Colors.white,
                  colorText: Colors.black,
                  text: 'Iniciar con Google',
                  radius: 50,
                  height: 8.sp,
                  icon: iconsUI.google),
            ),
          ],
        ),
      ),
      backgroundColor: colorsUI.secondary500,
    );
  }
}

