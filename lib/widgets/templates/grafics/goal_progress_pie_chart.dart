import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalProgressPieChart extends StatelessWidget {
  final double progreso;
  final double saldo;
  final double meta;

  const GoalProgressPieChart({
    super.key,
    required this.progreso,
    required this.saldo,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 10.0,
          percent: progreso.clamp(0.0, 1.0),
          center: Text(
            '${(progreso * 100).toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFAA2C),
            ),
          ),
          progressColor: const Color(0xFFFFAA2C),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
        ),
        const SizedBox(height: 12),
        Text(
          'Saldo: \$${saldo.toStringAsFixed(2)} / ${meta.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
