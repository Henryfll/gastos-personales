import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountCard extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final double saldo;
  final bool esCompartida;
  final VoidCallback? onEliminar;
  final VoidCallback? onCompartir;
  final VoidCallback? onEditar;
  final VoidCallback? onTap; // <-- Nueva propiedad

  const AccountCard({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.saldo,
    required this.esCompartida,
    this.onEliminar,
    this.onCompartir,
    this.onEditar,
    this.onTap, // <-- Agregada aquí también
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <-- Aquí se ejecuta
      child: Container(
        width: 300.sp,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.orange[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  nombre,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                  onSelected: (String result) {
                    switch (result) {
                      case 'eliminar':
                        onEliminar?.call();
                        break;
                      case 'compartir':
                        onCompartir?.call();
                        break;
                      case 'editar':
                        onEditar?.call();
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'editar',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'compartir',
                      child: Text('Compartir'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'eliminar',
                      child: Text('Eliminar'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              descripcion,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              '\$${(saldo ?? 0).toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                esCompartida ? Icons.family_restroom : Icons.perm_identity_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}