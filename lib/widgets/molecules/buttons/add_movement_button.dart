import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/widgets/atoms/dashed_border_painter.dart';

class AddMovementButton extends StatelessWidget {
  const AddMovementButton ({super.key, required this.onPressed, required this.texto, required this.tipo});

  final VoidCallback onPressed;
  final String texto;
  final String tipo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: tipo==AppConstants.INGRESO? Colors.green:Colors.red,
          strokeWidth: 1.0,
          dashLength: 5.0,
          dashSpace: 3.0,
        ),
        child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                texto,
                style: TextStyle(color: tipo==AppConstants.INGRESO? Colors.green:Colors.red),
              ),
              const SizedBox(width: 8.0),
               Icon(
                tipo==AppConstants.INGRESO? Icons.add:Icons.remove_sharp,
                color: tipo==AppConstants.INGRESO? Colors.green:Colors.red,
                size: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}