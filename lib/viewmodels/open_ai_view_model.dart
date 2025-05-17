import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/models/movement.dart';
import 'package:gastos/services/open_ai_service.dart';
import 'package:http/http.dart' as http;

class OpenAiViewModel extends ChangeNotifier {

  String? resultado;
  bool isLoading = false;
  final TextEditingController chatController = TextEditingController();
  final List<Map<String, String>> chatMessages = [];

  bool cargando = false;

  Future<void> procesarFactura(File imagen) async {
    isLoading = true;
    resultado = null;
    notifyListeners();

    resultado = await OpenAiService.procesarImagenFactura(imagen);

    isLoading = false;
    notifyListeners();
  }


  Future<void> inicializarConsejero(List<Movement> movimientos) async {
    final resumen = movimientos.map((m) =>
    '${m.tipo == AppConstants.INGRESO ? '+' : '-'} ${m.valor} en ${m.categoria} el ${m.fecha.toLocal()}').join('\n');

    chatMessages.clear();
    chatMessages.add({
      'role': 'system',
      "content": "Actúa como un asesor financiero personal. Basado en los siguientes movimientos financieros, responde preguntas del usuario.\n\n$resumen"
    });
    chatMessages.add({
      "role": "assistant",
      "content": "Hola soy ${AppConstants.chatBotName} tu asistente financiero, ¿cómo te puedo ayudar hoy?" });

    notifyListeners();
  }

  Future<void> enviarPregunta() async {
    final pregunta = chatController.text.trim();
    if (pregunta.isEmpty) return;

    chatMessages.add({'role': 'user', 'content': pregunta});
    chatController.clear();
    notifyListeners();

    cargando = true;
    notifyListeners();

    try {
      final response = await OpenAiService.enviarChat(chatMessages);
      chatMessages.add({'role': 'assistant', 'content': response});
    } catch (e) {
      chatMessages.add({'role': 'assistant', 'content': 'Ocurrió un error: $e'});
    } finally {
      cargando = false;
      notifyListeners();
    }
  }
}
