import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/viewmodels/account_viewmodel.dart';
import 'package:gastos/viewmodels/category_view_model.dart';
import 'package:gastos/viewmodels/login_viewmodel.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'firebase_options.dart';
import 'views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
      ],
      child: ResponsiveApp(
        builder: (context) => ScreenUtilInit(
          designSize: const Size(360, 760),
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
          ),
          child: const SplashView(), // 🔥 Esto es clave
        ),
      ),
    );
  }
}

