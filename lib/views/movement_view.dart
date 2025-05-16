import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/models/account.dart';
import 'package:gastos/viewmodels/category_view_model.dart';
import 'package:gastos/viewmodels/open_ai_view_model.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/widgets/molecules/buttons/add_movement_button.dart';
import 'package:gastos/widgets/molecules/buttons/add_movement_button_options.dart';
import 'package:gastos/widgets/molecules/buttons/add_new_button.dart';
import 'package:gastos/widgets/templates/footer/footer.dart';
import 'package:gastos/widgets/templates/grafics/movement_bar_chart.dart';
import 'package:gastos/widgets/templates/grafics/movement_line_chart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/account_viewmodel.dart';
import '../../viewmodels/movement_viewmodel.dart';
import '../../models/movement.dart';

class MovementsView extends StatelessWidget {
  const MovementsView({super.key});


  void _mostrarFormulario(BuildContext context, String tipo) {
    final _formKey = GlobalKey<FormState>();
    final _descripcionController = TextEditingController();
    final _valorController = TextEditingController();

    String? _categoriaSeleccionada;
    DateTime _fechaSeleccionada = DateTime.now();

    final categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    final usuario = Provider.of<UserViewModel>(context, listen: false).usuario;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tipo == AppConstants.INGRESO ? 'Nuevo Ingreso' : 'Nuevo Egreso',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Categoría con Dropdown desde stream
                tipo==AppConstants.EGRESO ? StreamBuilder<List<String>>(
                  stream: categoryViewModel.categoriesStream(usuario!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    final categorias = snapshot.data ?? [];

                    return DropdownButtonFormField<String>(
                      value: _categoriaSeleccionada,
                      items: categorias
                          .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _categoriaSeleccionada = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null ? 'Seleccione una categoría' : null,
                    );
                  },
                ):
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                // Descripción
                TextFormField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Valor
                TextFormField(
                  controller: _valorController,
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Ingrese un valor';
                    if (double.tryParse(value) == null) return 'Ingrese un número válido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Selector de fecha
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Fecha',
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.calendar_today),
                    hintText: '${_fechaSeleccionada.toLocal()}'.split(' ')[0],
                  ),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _fechaSeleccionada,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _fechaSeleccionada) {
                      setState(() {
                        _fechaSeleccionada = picked;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        final movementViewModel = Provider.of<MovementViewModel>(context, listen: false);
                        if (_formKey.currentState!.validate()) {
                          await movementViewModel.crearMovimiento(
                            tipo: tipo,
                            categoria: AppConstants.INGRESO==tipo ? "":_categoriaSeleccionada!,
                            descripcion: _descripcionController.text,
                            valor: double.parse(_valorController.text),
                            fecha: _fechaSeleccionada,
                            cuentaId: context.read<AccountViewModel>().accountSelected!.id,
                            usuarioCreacion: usuario!.uid,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _abrirCamara(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      final openAiVM = Provider.of<OpenAiViewModel>(context, listen: false);
      await openAiVM.procesarFactura(imageFile);

      // Mostrar el resultado si quieres
      final resultado = openAiVM.resultado;
      if (context.mounted && resultado != null) {

        final movementViewModel = Provider.of<MovementViewModel>(context, listen: false);
        final usuario = Provider.of<UserViewModel>(context, listen: false).usuario;
          await movementViewModel.crearMovimiento(
            tipo: AppConstants.EGRESO,
            categoria: AppConstants.FACTURA,
            descripcion: AppConstants.FACTURA,
            valor: double.parse(resultado),
            fecha: DateTime.now(),
            cuentaId: context.read<AccountViewModel>().accountSelected!.id,
            usuarioCreacion: usuario!.uid,
          );
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Egreso Registrado!'),
            content: Text(resultado),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } else {
      print('No se tomó ninguna foto.');
    }
  }


  @override
  Widget build(BuildContext context) {
    final accountViewModel = Provider.of<AccountViewModel>(context);
    final movementViewModel = Provider.of<MovementViewModel>(context);
    final account = accountViewModel.accountSelected;

    if (account == null) {
      return const Scaffold(body: Center(child: Text('Ninguna cuenta seleccionada')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('${account.nombre}')),
      body: Column(
        children: [
          StreamBuilder<List<Movement>>(
            stream: movementViewModel.listarMovimientosPorCuenta(account.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final movimientos = snapshot.data ?? [];

              double ingresos = 0.0;
              double egresos = 0.0;

              for (final movimiento in movimientos) {
                if(movimiento.tipo==AppConstants.INGRESO){
                  ingresos=ingresos+movimiento.valor;
                }else{
                  egresos=egresos+movimiento.valor;
                }
              }

              return  Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    AddMovementButton(
                      onPressed: () => _mostrarFormulario(context, AppConstants.INGRESO),
                      texto: "Ingresos ${ingresos}",
                      tipo: AppConstants.INGRESO,
                    ),
                    const SizedBox(width: 5),
                    Consumer<OpenAiViewModel>(builder: (context, openAiVM, child){
                      if (openAiVM.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return AddMovementButtonOptions(
                        onPressed: () {
                          // accion
                        },
                        onRegister:  () => _mostrarFormulario(context, AppConstants.EGRESO),
                        texto: "Egresos ${(egresos ?? 0).toStringAsFixed(2)}",
                        tipo: AppConstants.EGRESO,
                        onAutomatic: (){
                          _abrirCamara(context);
                        },
                      );

                    }),
                  ],
                ),
              );
            },
          ),
          StreamBuilder<Account>(
            stream: accountViewModel.getAccountById(account.id),
            builder: (context, accountSnapshot) {
              if (accountSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!accountSnapshot.hasData) {
                return const Center(child: Text('Cuenta no encontrada'));
              }

              final updatedAccount = accountSnapshot.data!;

              return  Text(
                'Saldo: \$${updatedAccount.saldo}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ) ;
            },
          ),

          StreamBuilder<List<Movement>>(
            stream: movementViewModel.listarMovimientosPorCuenta(account.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final movimientos = snapshot.data ?? [];

              return SizedBox(
                height: 200,
                child: MovementsBarChart(movimientos: snapshot.data!),
              );
            },
          ),
          const Text(
            'Movimientos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder<List<Movement>>(
              stream: movementViewModel.listarMovimientosPorCuenta(account.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final movimientos = snapshot.data ?? [];

                if (movimientos.isEmpty) {
                  return const Center(child: Text('No hay movimientos aún'));
                }

                return ListView.separated(
                  itemCount: movimientos.length,
                  separatorBuilder: (_, __) => const Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 2,
                  ),
                  itemBuilder: (context, index) {
                    final m = movimientos[index];
                    return ListTile(
                      leading: Icon(m.tipo == AppConstants.EGRESO ? Icons.arrow_downward : Icons.arrow_upward,
                          color: m.tipo == AppConstants.INGRESO ? Colors.green : Colors.red),
                      title: Text('\$${m.valor.toStringAsFixed(2)}'),
                      subtitle: Text('${m.categoria} - ${m.descripcion}'),
                      trailing: Text('${m.fecha.toLocal().toString().split(' ')[0]}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(page: 0),
    );
  }
}
