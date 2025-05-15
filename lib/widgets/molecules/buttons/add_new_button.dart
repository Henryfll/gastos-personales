import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/widgets/atoms/dashed_border_painter.dart';

class AddNewButton extends StatelessWidget {
  const AddNewButton({super.key, required this.onPressed, required this.texto});

  final VoidCallback onPressed;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: Colors.grey,
          strokeWidth: 1.0,
          dashLength: 5.0,
          dashSpace: 3.0,
        ),
        child: Container(
          width: 300.sp,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                texto,
                style: const TextStyle(color: Colors.orange),
              ),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.add,
                color: Colors.orange,
                size: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}