import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/viewmodels/open_ai_view_model.dart';
import 'package:gastos/widgets/templates/cards/chat_bubble.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final openAiVM = Provider.of<OpenAiViewModel>(context);

    // Filtra los mensajes que no son del sistema
    final mensajesVisibles = openAiVM.chatMessages
        .where((msg) => msg['role'] != 'system')
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.chatBotName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mensajesVisibles.length,
              itemBuilder: (context, index) {
                final msg = mensajesVisibles[index];
                final isUser = msg['role'] == 'user';
                return ChatBubble(
                  message: msg['content'] ?? '',
                  isUser: isUser,
                );
              },
            ),
          ),
          if (openAiVM.cargando)
             Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                color: colorsUI.secondary500,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: openAiVM.chatController,
                    decoration: InputDecoration(
                      hintText: 'Escribe tu pregunta...',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorsUI.secondary500, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon:  Icon(Icons.send, color: colorsUI.secondary500,),
                  onPressed: () {
                    openAiVM.enviarPregunta();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
