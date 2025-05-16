import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/models/movement.dart';

class MovementsLineChart extends StatelessWidget {
  final List<Movement> movimientos;

  const MovementsLineChart({super.key, required this.movimientos});

  @override
  Widget build(BuildContext context) {
    final ingresosPorFecha = <DateTime, double>{};
    final egresosPorFecha = <DateTime, double>{};

    for (final movimiento in movimientos) {
      final fecha = DateTime(movimiento.fecha.year, movimiento.fecha.month, movimiento.fecha.day);
      final mapa = movimiento.tipo == AppConstants.INGRESO ? ingresosPorFecha : egresosPorFecha;

      mapa.update(fecha, (valor) => valor + movimiento.valor, ifAbsent: () => movimiento.valor);
    }

    final fechasOrdenadas = ingresosPorFecha.keys.toSet().union(egresosPorFecha.keys.toSet()).toList()
      ..sort();

    List<FlSpot> ingresos = [];
    List<FlSpot> egresos = [];

    for (int i = 0; i < fechasOrdenadas.length; i++) {
      final fecha = fechasOrdenadas[i];
      ingresos.add(FlSpot(i.toDouble(), ingresosPorFecha[fecha] ?? 0));
      egresos.add(FlSpot(i.toDouble(), egresosPorFecha[fecha] ?? 0));
    }

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: ingresos,
              isCurved: true,
              barWidth: 3,
              color: Colors.green,
              dotData: FlDotData(show: false),
            ),
            LineChartBarData(
              spots: egresos,
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
              dotData: FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index >= 0 && index < fechasOrdenadas.length) {
                    final fecha = fechasOrdenadas[index];
                    return Text('${fecha.month}/${fecha.day}', style: const TextStyle(fontSize: 10));
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 20),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          gridData: FlGridData(show: true),
        ),
      ),
    );
  }
}
