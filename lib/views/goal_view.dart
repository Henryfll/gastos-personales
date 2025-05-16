import 'package:flutter/material.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/app/utils/paths/icons/icons.dart';
import 'package:gastos/views/deposit_view.dart';
import 'package:gastos/widgets/molecules/buttons/add_new_button.dart';
import 'package:gastos/widgets/templates/cards/goal_card.dart';
import 'package:gastos/widgets/templates/footer/footer.dart';
import 'package:gastos/widgets/templates/headers/topbar.dart';
import 'package:provider/provider.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/viewmodels/goal_viewmodel.dart';
import 'package:gastos/models/goal.dart';

class GoalView extends StatefulWidget {
  const GoalView({Key? key}) : super(key: key);

  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  final _formKey = GlobalKey<FormState>();

  void _showAddGoalModal(BuildContext context, {Goal? goal}) {
    final TextEditingController _nombreController = TextEditingController(text: goal?.nombre ?? '');
    final TextEditingController _metaController = TextEditingController(text: goal?.meta?.toString() ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
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
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(goal == null ? 'Crear Meta' : 'Editar Meta', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _metaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Meta'),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child:  Text('Cancelar', style: TextStyle(color: colorsUI.primary500),),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final nombre = _nombreController.text;
                      final meta = double.tryParse(_metaController.text) ?? 0.0;
                      final userId = Provider.of<UserViewModel>(context, listen: false).usuario!.uid;
                      final goalVM = Provider.of<GoalViewModel>(context, listen: false);

                      if (goal == null) {
                        await goalVM.crearMeta(nombre: nombre, meta: meta, userId: userId);
                      } else {
                        await goalVM.updateMeta(goalId: goal.id, nombre: nombre, meta: meta);
                      }

                      Navigator.pop(context);
                    },
                    child:  Text('Guardar', style: TextStyle(color: colorsUI.primary500),)
                  )
                ],
              )
            ],
          ),
        ));
      },
    );
  }

  void _confirmDeleteGoal(BuildContext context, String goalId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Meta'),
        content: const Text('¿Estás seguro de que deseas eliminar esta meta?'),
        actions: [
          TextButton(
            child:  Text('Cancelar', style: TextStyle(color: colorsUI.primary500),),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child:  Text('Eliminar', style: TextStyle(color: colorsUI.primary500),),
            onPressed: () async {
              final goalVM = Provider.of<GoalViewModel>(context, listen: false);
              await goalVM.deleteMeta(goalId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Meta eliminada exitosamente')),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context).usuario;

    if (user == null) {
      return const Center(child: Text("Usuario no autenticado"));
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TopBar(
              imageUrl: user?.photoUrl ?? '', userName: user?.name ?? ''),
          toolbarHeight: 70.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddNewButton(onPressed: () => _showAddGoalModal(context),
        texto: "Agregar nueva meta"),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Goal>>(
                stream: Provider.of<GoalViewModel>(context).listarMetasPorUsuario(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final metas = snapshot.data ?? [];

                  if (metas.isEmpty) {
                    return const Center(child: Text("No hay metas registradas"));
                  }

                  return ListView.separated(
                    itemCount: metas.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final goal = metas[index];
                      return GoalCard(
                          name: goal.nombre,
                          imagePath: iconsUI.apple,
                          value: goal.meta,
                        onEdit: () => _showAddGoalModal(context, goal: goal),
                        onEliminar: () => _confirmDeleteGoal(context, goal.id),
                        onTap: () {
                          print('Tapped on ${ goal.nombre}');
                          Provider.of<GoalViewModel>(context, listen: false).setGoalSelected(goal);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DepositView()),
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
      bottomNavigationBar: const Footer(page: 1),
    );
  }
}
