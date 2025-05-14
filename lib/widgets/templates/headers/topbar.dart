import 'package:flutter/material.dart';

import '../../../app/utils/colors/colors.dart';

class TopBar extends StatelessWidget {
  final String imageUrl;
  final String userName;

  const TopBar({super.key, required this.imageUrl, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white, // Asumiendo un fondo blanco
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Bienvenido!',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              const Icon(
                Icons.notifications_none_outlined,
                size: 30.0,
                color: Colors.grey,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: colorsUI.secondary500,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 8.0,
                    minHeight: 8.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}