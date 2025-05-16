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
    required this.tipo,
    this.onRegister,
    this.onAutomatic,
  });

  final VoidCallback onPressed; // Callback original del botón
  final String texto;
  final String tipo;
  final VoidCallback? onRegister; // Nuevo callback para "Registrar"
  final VoidCallback? onAutomatic; // Nuevo callback para "Automático"

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Mostrar el menú emergente al hacer tap en el botón
        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final RelativeRect position = RelativeRect.fromRect(
          context.findRenderObject()!.paintBounds.inflate(5.0),
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
                  const Icon(Icons.edit), // Icono de edición (puedes cambiarlo)
                  SizedBox(width: 8.w),
                  const Text('Registro Manual'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'automatico',
              child: Row(
                children: [
                  const Icon(Icons.camera_alt), // Icono de cámara (puedes cambiarlo)
                  SizedBox(width: 8.w),
                  const Text('Registro Automático'),
                ],
              ),
            ),
          ],
        ).then((String? selected) {
          // Manejar la opción seleccionada
          switch (selected) {
            case 'registrar':
              onRegister?.call();
              break;
            case 'automatico':
              onAutomatic?.call();
              break;
          // Si aún necesitas el onPressed original para otra acción por defecto:
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
              Text(
                texto,
                style: TextStyle(color: tipo == AppConstants.INGRESO ? Colors.green : Colors.red),
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