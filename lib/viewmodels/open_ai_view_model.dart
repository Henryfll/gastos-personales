import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OpenAiViewModel extends ChangeNotifier {
  final String apiKey = 'APIKEY';

  String? resultado;
  bool isLoading = false;

  Future<void> procesarFactura(File imagen) async {
    isLoading = true;
    resultado = null;
    notifyListeners();

    try {
      final bytes = await imagen.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "gpt-4o",
          "messages": [
            {
              "role": "user",
              "content": [
                {"type": "text", "text": "Extrae el total de la factura en la , solo el valor numérico sin la moneda."},
                {
                  "type": "image_url",
                  "image_url": {
                    "url": "data:image/jpeg;base64,$base64Image"
                  }
                }
              ]
            }
          ],
          "max_tokens": 100,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        resultado = data["choices"][0]["message"]["content"];
      } else {
        resultado = 'Error al procesar: ${response.statusCode}';
      }
    } catch (e) {
      resultado = 'Error: $e';
    } finally{
      isLoading = false;
      notifyListeners();
    }

  }
}
