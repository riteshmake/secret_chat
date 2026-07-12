import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SecretChatApp());
}

class SecretChatApp extends StatelessWidget {
  const SecretChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secret Chat',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}