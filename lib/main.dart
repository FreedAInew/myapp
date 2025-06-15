import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ✅ Usa super.key como recomendación de Dart moderno

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clipboard Auto Saver',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const HomeScreen(), // ⬅️ Aquí llamas tu pantalla principal
      debugShowCheckedModeBanner: false,
    );
  }
}
