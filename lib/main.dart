import 'package:flutter/material.dart';
import 'package:heloderma/screens/main_screen.dart';
import 'package:heloderma/colors.dart' as HelodermaColors;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heloderma',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: HelodermaColors.darkPink),
      ),
      home: const MainScreen(),
    );
  }
}
