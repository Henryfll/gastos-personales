import 'package:flutter/material.dart';
import 'dart:math';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;

  DashedBorderPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashLength = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    double startY = 0;

    // Dibujar borde superior
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(min(startX + dashLength, size.width), startY),
        paint,
      );
      startX += dashLength + dashSpace;
    }

    // Dibujar borde derecho
    double currentY = 0;
    while (currentY < size.height) {
      double endY = currentY + dashLength;
      if (endY > size.height) {
        endY = size.height;
      }
      canvas.drawLine(
        Offset(size.width, currentY),
        Offset(size.width, endY),
        paint,
      );
      currentY += dashLength + dashSpace;
    }

    // Dibujar borde inferior
    startX = 0;
    startY = size.height;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(min(startX + dashLength, size.width), startY),
        paint,
      );
      startX += dashLength + dashSpace;
    }

    // Dibujar borde izquierdo
    currentY = 0;
    while (currentY < size.height) {
      double endY = currentY + dashLength;
      if (endY > size.height) {
        endY = size.height;
      }
      canvas.drawLine(
        Offset(0, currentY),
        Offset(0, endY),
        paint,
      );
      currentY += dashLength + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}