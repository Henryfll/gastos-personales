import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/widgets/atoms/dashed_border_painter.dart';

class AddMovementButtonOptions extends StatelessWidget {
  const AddMovementButtonOptions({
    super.key,
    required this.onPressed,
    required this.texto,
    required this.valor,
    required this.tipo,
    this.onRegister,
    this.onAutomatic,
  });

  final VoidCallback onPressed;
  final String texto;
  final String valor;
  final String tipo;
  final VoidCallback? onRegister;
  final VoidCallback? onAutomatic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset buttonPosition = button.localToGlobal(Offset.zero);
        final Size buttonSize = button.size;
        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            buttonPosition.translate(buttonSize.width, 0),
            buttonPosition.translate(buttonSize.width, 0),
          ).inflate(5.0),
          overlay.localToGlobal(Offset.zero) & overlay.size,
        );

        showMenu<String>(
          context: context,
          position: position,
          items: <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'registrar',
              child: Row(
                children: [
                  const Icon(Icons.edit),
                  SizedBox(width: 8.w),
                  const Text('Registrar'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'automatico',
              child: Row(
                children: [
                  const Icon(Icons.camera_alt),
                  SizedBox(width: 8.w),
                  const Text('Escanear Factura'),
                ],
              ),
            ),
          ],
        ).then((String? selected) {

          switch (selected) {
            case 'registrar':
              onRegister?.call();
              break;
            case 'automatico':
              onAutomatic?.call();
              break;

            default:
              if (selected != null) {
                onPressed?.call();
              }
              break;
          }
        });
      },
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: tipo == AppConstants.INGRESO ? Colors.green : Colors.red,
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
             Column(
               children: [
                 Text(
                   texto,
                   style: TextStyle(color: tipo == AppConstants.INGRESO ? Colors.green : Colors.red),
                 ),
                 Text(
                   valor,
                   style: TextStyle(color: tipo == AppConstants.INGRESO ? Colors.green : Colors.red),
                 ),
               ],
             ),
              const SizedBox(width: 8.0),
              Icon(
                tipo == AppConstants.INGRESO ? Icons.add : Icons.remove_sharp,
                color: tipo == AppConstants.INGRESO ? Colors.green : Colors.red,
                size: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}