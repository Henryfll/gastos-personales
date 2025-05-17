import 'package:flutter/material.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/models/account.dart';
import 'package:gastos/viewmodels/account_viewmodel.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/views/movement_view.dart';
import 'package:gastos/widgets/molecules/buttons/add_new_button.dart';
import 'package:gastos/widgets/templates/cards/account_card.dart';
import 'package:gastos/widgets/templates/footer/footer.dart';
import 'package:gastos/widgets/templates/headers/topbar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showAccountModal(BuildContext context, {Account? cuenta}) {
    final isEditing = cuenta != null;
    if (isEditing) {
      _nameController.text = cuenta.nombre;
      _descriptionController.text = cuenta.descripcion;
    } else {
      _nameController.clear();
      _descriptionController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return  Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme:  InputDecorationTheme(
                labelStyle: TextStyle(color: colorsUI.primary500),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorsUI.primary500),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorsUI.primary500),
                ),
              ),
              textSelectionTheme:  TextSelectionThemeData(
                cursorColor: colorsUI.primary500,
              ),
            ),
          child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isEditing ? 'Editar Cuenta' : 'Nueva Cuenta',
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la Cuenta',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child:  Text('Cancelar', style: TextStyle(color: colorsUI.primary500),)
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final nombre = _nameController.text;
                          final descripcion = _descriptionController.text;
                          final accountViewModel = Provider.of<AccountViewModel>(context, listen: false);
                          final userViewModel = Provider.of<UserViewModel>(context, listen: false);

                          if (isEditing) {
                            await accountViewModel.updateAccount(
                              accountId: cuenta!.id,
                              nombre: nombre,
                              descripcion: descripcion,
                            );
                          } else {
                            await accountViewModel.addAccount(
                              nombre: nombre,
                              descripcion: descripcion,
                              usuarioId: userViewModel.usuario!.uid,
                            );
                          }

                          Navigator.pop(context);
                          _nameController.clear();
                          _descriptionController.clear();
                        }
                      },
                      child: Text('Guardar', style: TextStyle(color: colorsUI.primary500),)
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
  Future<void> _confirmarYEliminarCuenta(BuildContext context, Account cuenta) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: const Text('¿Estás seguro de que deseas eliminar esta cuenta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:  Text('Cancelar', style: TextStyle(color: colorsUI.primary500),)
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child:  Text('Eliminar', style: TextStyle(color: colorsUI.primary500),)
          ),
        ],
      ),
    );

    if (confirm == true) {
      final accountViewModel = Provider.of<AccountViewModel>(context, listen: false);
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      final currentUserId = userViewModel.usuario!.uid;

      try {
        await accountViewModel.deleteAccount(
          accountId: cuenta.id,
          userId: currentUserId,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta eliminada con éxito')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
  void _showShareAccountModal(BuildContext context, Account cuenta) {
    final _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme:  InputDecorationTheme(
                labelStyle: TextStyle(color: colorsUI.primary500),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorsUI.primary500),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorsUI.primary500),
                ),
              ),
              textSelectionTheme:  TextSelectionThemeData(
                cursorColor: colorsUI.primary500,
              ),
            ),
            child:Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Compartir cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email del usuario',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Por favor, ingresa un email';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Email inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child:  Text('Cancelar', style: TextStyle(color: colorsUI.primary500),)),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final accountViewModel = Provider.of<AccountViewModel>(context, listen: false);
                          final email = _emailController.text.trim();

                          final result = await accountViewModel.shareAccount(
                            accountId: cuenta.id,
                            email: email,
                          );

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result)),
                          );
                        }
                      },
                      child:  Text('Compartir', style: TextStyle(color: colorsUI.primary500),)
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
      },
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UserViewModel>(context).usuario;
    final accountViewModel = Provider.of<AccountViewModel>(context, listen: false);

    if (usuario == null) {
      return const Center(child: Text('Usuario no autenticado'));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TopBar(
            imageUrl: usuario?.photoUrl ?? '', userName: usuario?.name ?? ''),
        toolbarHeight: 70.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            AddNewButton(
                texto: "Añadir Cuenta",
                onPressed: () => _showAccountModal(context)),

            SizedBox(height: 16),

            
            Expanded(
              child: StreamBuilder<List<Account>>(
                stream: accountViewModel.accountsStream(usuario.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final cuentas = snapshot.data ?? [];

                  if (cuentas.isEmpty) {
                    return const Center(child: Text("No hay cuentas registradas"));
                  }

                  return ListView.separated(
                    itemCount: cuentas.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final cuenta = cuentas[index];
                      return AccountCard(
                        nombre: cuenta.nombre,
                        descripcion: cuenta.descripcion,
                        saldo: cuenta.saldo,
                        esCompartida: cuenta.userId != usuario.uid,
                        onEliminar: () => _confirmarYEliminarCuenta(context, cuenta),
                        onCompartir: () {
                          _showShareAccountModal(context, cuenta);
                        },
                        onEditar: () {
                          _nameController.text = cuenta.nombre;
                          _descriptionController.text = cuenta.descripcion;
                          _showAccountModal(context, cuenta: cuenta);
                        },
                        onTap: () {
                          print('Cuenta seleccionada');
                          Provider.of<AccountViewModel>(context, listen: false).setAccountSelected(cuenta);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MovementsView()),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(page: 0),
    );
  }
}