import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OpenAiService {
  static const _apiKey = 'APIKEY';
  static const _endpoint = 'https://api.openai.com/v1/chat/completions';

  static Future<String> procesarImagenFactura(File imagen) async {
    try {
      final bytes = await imagen.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "gpt-4o",
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                  "Extrae el total de la factura, solo el valor numérico sin la moneda.",
                },
                {
                  "type": "image_url",
                  "image_url": {
                    "url": "data:image/jpeg;base64,$base64Image",
                  },
                },
              ],
            }
          ],
          "max_tokens": 100,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"];
      } else {
        return 'Error al procesar: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  static Future<String> enviarChat(List<Map<String, String>> messages) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': messages,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final content = data['choices'][0]['message']['content'];
      return content.trim();
    } else {
      throw Exception(
          'Error en la API (${response.statusCode}): ${response.body}');
    }
  }
}
