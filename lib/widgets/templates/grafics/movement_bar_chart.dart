import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/models/movement.dart';

class MovementsBarChart extends StatelessWidget {
  final List<Movement> movimientos;

  const MovementsBarChart({super.key, required this.movimientos});

  @override
  Widget build(BuildContext context) {
    if (movimientos.isEmpty) {
      return const Center(child: Text("No hay movimientos"));
    }


    movimientos.sort((a, b) => a.fecha.compareTo(b.fecha));
    final maxValor = movimientos.map((e) => e.valor).reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 250,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY:  maxValor * 1.1,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < movimientos.length) {
                      final fecha = movimientos[index].fecha;
                      return Text(
                        "${fecha.day}/${fecha.month}",
                        style: const TextStyle(fontSize: 10),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Transform.rotate(
                      angle: 0, // 👈 Horizontal (0 radianes)
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                  reservedSize: 30,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: movimientos.asMap().entries.map((entry) {
              final index = entry.key;
              final movimiento = entry.value;
              final color = movimiento.tipo == AppConstants.INGRESO ? Colors.green : Colors.red;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: movimiento.valor,
                    color: color,
                    width: 15,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
