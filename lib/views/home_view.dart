import 'package:flutter/material.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/widgets/templates/footer/footer.dart';
import 'package:gastos/widgets/templates/headers/topbar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    final usuario = Provider.of<UserViewModel>(context).usuario;

    return Scaffold(
      body: const Center(
        child: Text(
          'Mis cuentas',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: const Footer(page: 0),
      appBar: AppBar(
      automaticallyImplyLeading: false,
      title:  TopBar(imageUrl: usuario?.photoUrl ?? '',userName: usuario?.name?? ''),
      toolbarHeight: 70.0,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    );
  }
}
