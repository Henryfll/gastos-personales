import 'package:flutter/material.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/models/goal.dart';
import 'package:gastos/widgets/molecules/buttons/add_new_button.dart';
import 'package:gastos/widgets/templates/footer/footer.dart';
import 'package:gastos/widgets/templates/grafics/goal_progress_pie_chart.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/goal_viewmodel.dart';
import '../../viewmodels/deposit_viewmodel.dart';
import '../../models/deposit.dart';

class DepositView extends StatelessWidget {
  const DepositView({super.key});

  @override
  Widget build(BuildContext context) {
    final goalViewModel = Provider.of<GoalViewModel>(context);
    final depositViewModel = Provider.of<DepositViewModel>(context);
    final goal = goalViewModel.goalSelected;

    if (goal == null) {
      return const Scaffold(
        body: Center(child: Text('Ninguna meta seleccionada')),
      );
    }

    void _showAddDepositModal() {
      final _formKey = GlobalKey<FormState>();
      final _valorController = TextEditingController();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => Theme(
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
            left: 16, right: 16, top: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Nuevo Depósito', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child:  Text('Cancelar', style: TextStyle(color: colorsUI.primary500),),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await depositViewModel.agregarDeposito(
                            goalId: goal.id,
                            valor: double.parse(_valorController.text),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child:  Text('Guardar', style: TextStyle(color: colorsUI.primary500),),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${goal.nombre}'),
      ),
      body: StreamBuilder<Goal>(
        stream: goalViewModel.getGoalById(goal.id),
        builder: (context, goalSnapshot) {
          if (goalSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!goalSnapshot.hasData) {
            return const Center(child: Text('Meta no encontrada'));
          }

          final updatedGoal = goalSnapshot.data!;
          final progreso = (updatedGoal.saldo / updatedGoal.meta).clamp(0.0, 1.0);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GoalProgressPieChart(
                  progreso: progreso,
                  saldo: updatedGoal.saldo,
                  meta: updatedGoal.meta,
                ),
                const SizedBox(height: 16),
                goal.saldo >= goal.meta
                    ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '🎉 ¡Meta cumplida!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                )
                    :
                AddNewButton(onPressed: _showAddDepositModal, texto: "Agregar Depósito"),
                const SizedBox(height: 16),
                const Text(
                  'Últimos depósitos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: StreamBuilder<List<Deposit>>(
                    stream: depositViewModel.listarDepositosPorGoal(updatedGoal.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final depositos = snapshot.data ?? [];

                      if (depositos.isEmpty) {
                        return const Center(child: Text('No hay depósitos aún'));
                      }

                      return ListView.separated(
                        itemCount: depositos.length,
                        separatorBuilder: (_, __) => const Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 2,
                        ),
                        itemBuilder: (context, index) {
                          final deposito = depositos[index];
                          final fechaFormateada = deposito.fecha.toLocal().toIso8601String().substring(0, 10); // yyyy-MM-dd
                          return ListTile(
                            leading: const Icon(Icons.arrow_upward_outlined, color: Colors.green),
                            title: Text(
                              '\$${deposito.valor.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              fechaFormateada,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const Footer(page: 1),
    );
  }
}
