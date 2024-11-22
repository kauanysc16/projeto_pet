import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/main.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Inicializa o serviço de notificações
  void initialize() {
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Handle foreground messages
        print('Mensagem recebida: ${message.data}');
        print('Notificação: ${message.notification}');

        // Aqui você pode adicionar lógica para exibir notificações no app
        _showNotification(message);
      }
    });
  }

  // Exibe a notificação no app
  void _showNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      // Exibindo uma notificação simples como exemplo
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(notification.title ?? 'Nova Notificação'),
            content:
                Text(notification.body ?? 'Você tem uma nova notificação.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }

  // Inscreve o usuário em um tópico de notificações
  void subscribeToTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
    print('Inscrito no tópico: $topic');
  }
}
